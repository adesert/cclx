
local MoveState = class("MoveState",require("game.creature.machine.state.IState"))

function MoveState:ctor()
	self.super.ctor(self)
end

function MoveState:_overrideInit()
    self:getOwner():removeWeapon()
    self:getOwner():setAction(CREATURE_ACTION_NAME.MOVE)
end


return MoveState