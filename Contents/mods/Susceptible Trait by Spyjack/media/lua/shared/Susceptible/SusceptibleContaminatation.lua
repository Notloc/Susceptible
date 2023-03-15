local THREAT_STEP = 0.004
local AVERAGING_STEP = 0.0002
local AREA_COEFFICIENT = 0.25

local ROOMS_PER_UPDATE = 4

local startTime = {
    year = 1993,
    month = 6,
    day = 1,
    hour = 0,
    minute = 0
}

local function lerp(a, b, t)
    if t < 0 then
        return a
    elseif t > 1 then
        return b
    end
    return a + (b - a) * t
end

local function isServerOrLocalGame()
    return isServer() or not isClient()
end

local function getNow()
    local gameTime = getGameTime()
    return {
        year = gameTime:getYear(),
        month = gameTime:getMonth(),
        day = gameTime:getDay(),
        hour = gameTime:getHour(),
        minute = gameTime:getMinutes()
    }
end

local function getMinuteDifference(startTime, endTime)
    local minutes = 0
    minutes = minutes + (endTime.year - startTime.year) * 525600
    minutes = minutes + (endTime.month - startTime.month) * 43800
    minutes = minutes + (endTime.day - startTime.day) * 1440
    minutes = minutes + (endTime.hour - startTime.hour) * 60
    minutes = minutes + (endTime.minute - startTime.minute)
    return minutes
end

-- We use the minimum coordinates of the room as its ID
local function findMinimumSquareCoordinates(squares)
    local minSquare = squares:get(0)
    local maxSquare = squares:get(0)
    
    for i = 1, squares:size() - 1 do
        local sqr = squares:get(i)
        local x = sqr:getX()
        local y = sqr:getY()
        
        if y < minSquare:getY() then
            minSquare = sqr
        elseif y == minSquare:getY() then
            if x < minSquare:getX() then
                minSquare = sqr
            end
        end  
        
        if y > maxSquare:getY() then
            maxSquare = sqr
        elseif y == maxSquare:getY() then
            if x > maxSquare:getX() then
                maxSquare = sqr
            end
        end
    end
    return minSquare, maxSquare
end

local firstUpdate = true

SusceptibleContamination = {}

SusceptibleContamination.cachedData = {}
SusceptibleContamination.roomsToProcessByBuilding = {}
SusceptibleContamination.updateIndex = 1

SusceptibleContamination.CountZombiesAndBodiesInRoom = function(room)
    local zombieCount = 0
    local bodyCount = 0
    for i = 0, room:getSquares():size() - 1 do
        local sqr = room:getSquares():get(i)
        if sqr:getZombie() then
            zombieCount = zombieCount + 1
        end

        local body = sqr:getDeadBody()
        if body and body:isZombie() then
            bodyCount = bodyCount + 1
        end
    end
    return zombieCount, bodyCount
end

SusceptibleContamination.getThreatBySquare = function(square)
    if not square then return 0 end
    return SusceptibleContamination.getThreatByRoom(square:getRoom())
end

SusceptibleContamination.getThreatByRoom = function(room)
    if not room then return 0 end

    if SusceptibleContamination.cachedData[room] then
        return SusceptibleContamination.cachedData[room].threatLevel
    end

    local key = findMinimumSquareCoordinates(room:getSquares())
    if SusceptibleContamination.persistentRoomData[key] then
        SusceptibleContamination.cachedData[room] = SusceptibleContamination.persistentRoomData[key]
        return SusceptibleContamination.persistentRoomData[key].threatLevel
    end

    return 0
end

-- Temporary, use mod data later
SusceptibleContamination.persistentRoomData = {}

SusceptibleContamination.OnEveryTenMinutes = function()
    if not isServerOrLocalGame() or SusceptibleContamination.updateInProgress then
        return
    end

    local roomsToProcessByBuilding = SusceptibleContamination.roomsToProcessByBuilding

    local players = getOnlinePlayers() or IsoPlayer.getPlayers()
    for i = 0, players:size() - 1 do
        local player = players:get(i)
        if player then
            local loadedRooms = player:getCell():getRoomList()
            for i = 0, loadedRooms:size() - 1 do
                local room = loadedRooms:get(i)
                local roomDef = room:getRoomDef()
                local buildingId = room:getBuilding():getID()

                if not roomsToProcessByBuilding[buildingId] then
                    roomsToProcessByBuilding[buildingId] = {}
                end
                table.insert(roomsToProcessByBuilding[buildingId], room)
            end
        end
    end

    -- Convert to an indexed table
    local roomsByBuilding = {}
    for bId, rooms in pairs(roomsToProcessByBuilding) do
        table.insert(roomsByBuilding, rooms)
    end
    
    SusceptibleContamination.roomsToProcessByBuilding = roomsByBuilding
    SusceptibleContamination.updateIndex = 1
    SusceptibleContamination.updateInProgress = true
end

local counter = 0
SusceptibleContamination.OnTick = function()
    if not SusceptibleContamination.updateInProgress or not isServerOrLocalGame() then
        return
    end

    local now = getNow()
    local totalRoomsUpdated = 0
    if firstUpdate then
        totalRoomsUpdated = -100000
    end

    while true do
        if SusceptibleContamination.updateIndex > #SusceptibleContamination.roomsToProcessByBuilding then
            SusceptibleContamination.updateInProgress = false
            SusceptibleContamination.roomsToProcessByBuilding = {}
            firstUpdate = false
            return
        end

        if not SusceptibleContamination.buildingContext then
            SusceptibleContamination.buildingContext = {
                rooms = SusceptibleContamination.roomsToProcessByBuilding[SusceptibleContamination.updateIndex],
                unloadedRooms = {},
                keysByRoom = {},
                currentRoomIndex = 1,

                totalThreatXArea = 0,
                totalArea = 1,
                totalMinutes = 0
            }
        end

        local roomsUpdated, complete = SusceptibleContamination.updateBuildingRooms(SusceptibleContamination.buildingContext, now, totalRoomsUpdated)
        if complete then
            SusceptibleContamination.averageBuildingRooms(SusceptibleContamination.buildingContext)
            SusceptibleContamination.buildingContext = nil
            SusceptibleContamination.updateIndex = SusceptibleContamination.updateIndex + 1
        end

        totalRoomsUpdated = roomsUpdated
        if totalRoomsUpdated >= ROOMS_PER_UPDATE then
            return
        end
    end
end

SusceptibleContamination.updateBuildingRooms = function(buildingContext, now, count)
    local totalThreatXArea = 0
    local totalArea = 1
    local totalMinutes = 1
    
    local keysByRoom = buildingContext.keysByRoom
    local unloadedRooms = buildingContext.unloadedRooms

    local completedBuilding = true
        
    for i = buildingContext.currentRoomIndex, #buildingContext.rooms do
        if count >= ROOMS_PER_UPDATE then
            buildingContext.currentRoomIndex = i
            completedBuilding = false
            break
        end

        local room = buildingContext.rooms[i]
        -- Remove this later, its for an easy break point
        if getPlayer():getCurrentSquare():getRoom() == room then
            local x = 32143
        end


        if room and room:getSquares():size() == 0 then
            table.insert(unloadedRooms, room)
        else
            local key = findMinimumSquareCoordinates(room:getSquares())
            keysByRoom[room] = key

            if not SusceptibleContamination.persistentRoomData[key] then
                SusceptibleContamination.persistentRoomData[key] = {
                    threatLevel = 0
                }
            end
            
            local zombieCount, bodyCount = SusceptibleContamination.CountZombiesAndBodiesInRoom(room)
            
            local data = SusceptibleContamination.persistentRoomData[key]
            local lastUpdateTime = data.lastUpdateTime or startTime
            local minutes = getMinuteDifference(lastUpdateTime, now)
        
            local area = room:getRoomDef():getArea()

            local activeThreat = (zombieCount * 2 + bodyCount) / (area^AREA_COEFFICIENT)
            if activeThreat > data.threatLevel then
                data.threatLevel = lerp(data.threatLevel, activeThreat, THREAT_STEP * minutes)
            else
                data.threatLevel = lerp(data.threatLevel, activeThreat, THREAT_STEP * minutes * 0.2)
            end
            data.lastUpdateTime = now

            totalThreatXArea = totalThreatXArea + data.threatLevel * area
            totalArea = totalArea + area
            totalMinutes = totalMinutes + minutes
            count = count + 1
        end
    end

    buildingContext.totalThreatXArea = buildingContext.totalThreatXArea + totalThreatXArea
    buildingContext.totalArea = buildingContext.totalArea + totalArea
    buildingContext.totalMinutes = buildingContext.totalMinutes + totalMinutes

    return count, completedBuilding
end

SusceptibleContamination.averageBuildingRooms = function (buildingContext)
    local avgThreat = buildingContext.totalThreatXArea / buildingContext.totalArea
    local avgMinutes = buildingContext.totalMinutes / (#buildingContext.rooms - #buildingContext.unloadedRooms)
    for _, room in ipairs(buildingContext.rooms) do
        if buildingContext.keysByRoom[room] then
            local data = SusceptibleContamination.persistentRoomData[buildingContext.keysByRoom[room]]
            data.threatLevel = lerp(data.threatLevel, avgThreat, AVERAGING_STEP * avgMinutes)
        end
    end
end

Events.EveryTenMinutes.Add(SusceptibleContamination.OnEveryTenMinutes)
Events.OnTick.Add(SusceptibleContamination.OnTick)