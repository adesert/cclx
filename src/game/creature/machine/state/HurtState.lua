local HurtState = class("HurtState",require("game.creature.machine.state.IState"))

function HurtState:ctor()
	self.super.ctor(self)
end

function HurtState:_overrideInit()
    self:getOwner():removeWeapon()
    self:getOwner():setAction(CREATURE_ACTION_NAME.HURT)
end

return HurtState