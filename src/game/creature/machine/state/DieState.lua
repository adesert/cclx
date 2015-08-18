local DieState = class("DieState",require("game.creature.machine.state.IState"))

function DieState:ctor()
	self.super.ctor(self)
end

function DieState:_overrideInit()
    self:getOwner():removeWeapon()
    self:getOwner():setAction(CREATURE_ACTION_NAME.DIE)
end

return DieState