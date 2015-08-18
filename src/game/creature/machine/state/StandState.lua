
local StandState = class("StandState",require("game.creature.machine.state.IState"))

function StandState:ctor()
	self.super.ctor(self)
end

function StandState:_overrideInit()
    self:getOwner():removeWeapon()
    self:getOwner():setAction(CREATURE_ACTION_NAME.STAND)
end

return StandState