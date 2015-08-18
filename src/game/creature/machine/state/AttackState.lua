
-- 普通攻击，没有技能特效
local AttackState = class("AttackState",require("game.creature.machine.state.IState"))

function AttackState:ctor()
	self.super.ctor(self)
end

function AttackState:_overrideInit()
    local actionName = self:getOwner():getAttr(ATTR_DEFINE.ACTION_NAME)
    self:getOwner():setAction(actionName)
end

return AttackState