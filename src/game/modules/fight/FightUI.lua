
local FightUI = class("FightUI",require("game.base.BaseLayer"))

function FightUI:ctor()
	self.super.ctor(self)
end

function FightUI:_overrideInit()
    self.ccb = self:loadCCB("fight_ui")
    self.ccb:setCallFunc("fight_func",handler(self,self.fight_func))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    self:_init()
    self:_initdata()
end

function FightUI:_init()
    
end

function FightUI:_initdata()
    
end

function FightUI:fight_func()
	
end

function FightUI:clear()
    
end

return FightUI