
-- 玩家状态机
local PlayerMachine = class("PlayerState",require("game.creature.machine.IStateMachine"))

function PlayerMachine:ctor()
	self.super.ctor(self)
end

-- 动作播放完成
function PlayerMachine:actionPlayCompleted()
    local cState = self:getCurrentState()
    local preState = self:getPreState()
    local creature = self:getOwner()
    if cState == MACHINE_STATE_TYPE.DIE then
        global.objMgr:destroyObject(creature:getAttr(ATTR_DEFINE.ID))
        global.currentPlayer = nil
    elseif cState == MACHINE_STATE_TYPE.HURT then
        if preState then
            self:changeState(preState)
        else
            self:changeState(MACHINE_STATE_TYPE.STAND)
        end
    elseif cState == MACHINE_STATE_TYPE.ATTACK or cState == MACHINE_STATE_TYPE.SKILL then
        if preState then
            self:changeState(preState)
        else
            self:changeState(MACHINE_STATE_TYPE.STAND)
        end
    end
end

return PlayerMachine