
local SkillState = class("SkillState",require("game.creature.machine.state.IState"))

function SkillState:ctor()
	self.super.ctor(self)
end

function SkillState:_overrideInit()
    self:getOwner():removeWeapon()
    local actionName = self:getOwner():getAttr(ATTR_DEFINE.ACTION_NAME)
    self:getOwner():setAction(actionName)
end

return SkillState