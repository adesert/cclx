
local BossMachine = class("BossMachine",require("game.creature.machine.IStateMachine"))

function BossMachine:ctor()
	self.super.ctor(self)
end

function BossMachine:actionPlayCompleted()
    local cState = self:getCurrentState()
    local preState = self:getPreState()
    local creature = self:getOwner()
    if cState == MACHINE_STATE_TYPE.DIE then
        global.objMgr:destroyObject(creature:getAttr(ATTR_DEFINE.ID))
    elseif cState == MACHINE_STATE_TYPE.HURT then
        if preState then
            self:changeState(preState)
        else
            self:changeState(MACHINE_STATE_TYPE.MOVE)
        end
    elseif cState == MACHINE_STATE_TYPE.ATTACK or cState == MACHINE_STATE_TYPE.SKILL then
        creature:getAI():completeAction()
    end
end

return BossMachine