local UiUtil = require 'Susceptible/UiUtil'
local SusUtil = require 'Susceptible/SusceptibleUtil'

SusceptibleContaminationUi = ISUIElement:derive("SusceptibleContaminationUi");

function lerp(a,b,t)
    if t < 0 then return a end
    if t > 1 then return b end
    return a + (b-a)*t
end

function SusceptibleContaminationUi:new (playerNum)
	local o = ISUIElement:new(0,0,0,0);
	setmetatable(o, self)
    self.__index = self

    o.playerNum = playerNum;
	o.overlay = getTexture("media/ui/Susceptible/contamination_overlay.png");
    
    o.alpha = 0
    o.contaminationLevel = 0

	return o;
end

function SusceptibleContaminationUi:render()
    self.alpha = lerp(self.alpha, self.contaminationLevel, 0.016)

    local width = getCore():getScreenWidth()
    local height = getCore():getScreenHeight()

    local widthOffset = width*0.08
    local heightOffset = height*0.08
    local t = getTimestampMs() / 2000
    
	self:drawTextureScaled(self.overlay, -width * 0.1, -height * 0.1, width*1.2, height*1.2, self.alpha, 1, 1, 1);
	self:drawTextureScaled(self.overlay, (-width * 0.15) + math.sin(t/3) * widthOffset, (-height * 0.15) + math.cos(t/3) * heightOffset, width*1.3, height*1.3, self.alpha + math.sin(t/17) * 0.15, 1, 1, 1);
	self:drawTextureScaled(self.overlay, (-width * 0.1) + math.cos(t/7) * widthOffset, (-height * 0.1) + math.sin(t/7) * heightOffset, width*1.2, height*1.2, self.alpha, 1, 1, 1);
end

function SusceptibleContaminationUi:setContaminationLevel(level)
    level = level / 1.5
    if level > 0.5 then
        level = 0.5
    end
    self.contaminationLevel = level
end
