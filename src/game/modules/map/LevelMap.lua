
local LevelMap = class("LevelMap",require("game.base.BaseLayer"))

function LevelMap:ctor()
	self.super.ctor(self)
end

function LevelMap:_overrideIn()
    self:setPassEvent(true)
    self:showMaskBG()
end

return LevelMap