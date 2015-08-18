
local Player = class("Player",require("game/spine/BaseSpine"))

function Player:ctor(data)
	self.super.ctor(self,data)
end

function Player:_overrideBaseSpineInit()
	
end

function Player:clear()
	
end

return Player