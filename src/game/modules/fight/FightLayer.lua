
local FightLayer = class("FightLayer",require("game.base.BaseLayer"))

function FightLayer:ctor()
	self.super.ctor(self)
	self:_init()
end

function FightLayer:_init()
    self.map = require("game.modules.fight.map.FMap").new()
    self:addChild(self.map)
    
	self.fight_ui = require("game.modules.fight.FightUI").new()
	self:addChild(self.fight_ui)
	
	self.rocker = require("game.modules.fight.MapRocker").new()
	self:addChild(self.rocker)
end

function FightLayer:clear()
    self.map:clear()
    self.fight_ui:clear()
    self.rocker:clear()
end

return FightLayer
