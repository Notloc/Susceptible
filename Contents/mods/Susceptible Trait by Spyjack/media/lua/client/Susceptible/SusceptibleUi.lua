local UiUtil = require 'Susceptible/UiUtil'

SusceptibleUi = ISPanel:derive("SusceptibleUi");

local GREY = {r=1, g=1, b=1, a=1}
local ORANGE = {r=1, g=1, b=0, a=1}
local RED = {r=1, g=0, b=0, a=1}

local OSCILLATION_DELAY = 12;
local MASK_BUTTON_X = 11

function SusceptibleUi:render()
	if self.hasMask then
		UiUtil.drawOutlinedBar(self, 8, 50, 2, 38, 6, self.maskDelta, {r=0.6,g=1,b=0.6,a=1});
        UiUtil.updateOscillation(self.maskButton);
    else
        self.maskButton:setX(MASK_BUTTON_X);
        self.maskButton.oscillationData.delta = 0;
	end
end

function SusceptibleUi:onOptionMouseDown(button, x, y)
end

function SusceptibleUi:updateMaskInfo(item, maskDelta, threatDelta)
	if threatDelta > 1 then
		self.maskButton:setImage(self.virusTex);
	elseif item then
		self.maskButton:setImage(item:getTex());
	else
		self.maskButton:setImage(self.maskIconOff);
    end
	self.maskDelta = maskDelta;

	self.hasMask = item ~= nil;

	local col = UiUtil.triLerpColors(threatDelta, GREY, ORANGE, RED);
	self.maskBg:setColor(col.r, col.g, col.b);
end

function SusceptibleUi:new (x, y, chr)
	local o = {}
	o = ISPanel:new(x, y, 64, 64);
	setmetatable(o, self)
    self.__index = self
	o.x = x;
	o.y = y;
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=0};
    o.backgroundColor = {r=0, g=0, b=0, a=0};
    o.anchorLeft = true;
    o.chr = chr;
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;

	o.backgroundTex = getTexture("media/ui/HandMain2_Off.png");
	o.maskIconOff = getTexture("media/ui/Susceptible/maskoff.png");
	o.virusTex = getTexture("media/ui/Susceptible/virus.png");

	o.maskDelta = 0.0;
    o.oscillationTick = 0;

    SusceptibleUi.instance = o;
	return o;
end

function SusceptibleUi:destroyUi()
    self:clearChildren();
    self:close();
    self:removeFromUIManager();
end

function SusceptibleUi:initialise()
	ISPanel.initialise(self);

    self.maskBg = ISImage:new(4, 0, self.backgroundTex:getWidthOrig(), self.backgroundTex:getHeightOrig(), self.backgroundTex);
    self.maskBg:initialise();
    self.maskBg.parent = self;
    self:addChild(self.maskBg);

	self.maskButton = ISButton:new(MASK_BUTTON_X, 7, 32, 32, "", self, SusceptibleUi.onOptionMouseDown);
    self.maskButton:setImage(self.maskIcon);
    self.maskButton.internal = "MASK";
    self.maskButton:initialise();
    self.maskButton:instantiate();
    self.maskButton:setDisplayBackground(false);

    local oscillateCondition = function() 
            return self.maskDelta <= 0.2; 
        end;

    UiUtil.setupOscillation(self.maskButton, MASK_BUTTON_X, OSCILLATION_DELAY, oscillateCondition);

    self.maskButton.borderColor = {r=1, g=1, b=1, a=0.1};
    self.maskButton:ignoreWidthChange();
    self.maskButton:ignoreHeightChange();
	self:addChild(self.maskButton); 
end
