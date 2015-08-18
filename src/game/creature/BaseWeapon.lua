
local BaseWeapon = class("BaseWeapon",require("game.creature.BaseObject"))

function BaseWeapon:ctor(data)
    self.super.ctor(self,data)
end
function BaseWeapon:_overrideBaseObjectInit()
	
end

function BaseWeapon:_overrideBaseObjectAttackCall(i)
    combat_op.handleWeaponFunc(self)
end

function BaseWeapon:setCreature(owner)
    self.m_creature = owner
end

function BaseWeapon:getCreature()
    return self.m_creature
end

function BaseWeapon:clear()
	
end

return BaseWeapon