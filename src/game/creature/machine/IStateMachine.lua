
-- 状态机
local IStateMachine = class("IStateMachine")

function IStateMachine:ctor()
end

function IStateMachine:init(creature)
    self.m_creature = creature
end

function IStateMachine:getOwner()
    return self.m_creature
end

function IStateMachine:getPreState()
    return self.m_pre_state
end

function IStateMachine:getCurrentState()
    return self.m_currentState
end

-- 动作播放完成
function IStateMachine:actionPlayCompleted()
end

function IStateMachine:changeState(state)
    if self.m_currentState == state then
        return
    end
    if self.m_currentState then
        self.m_pre_state = self.m_currentState
    end
    self.m_currentState = state

    self:_overrideHaveChangeState()
end

-- 状态已经改变
function IStateMachine:_overrideHaveChangeState()
    local istate = nil
    if self.m_currentState == MACHINE_STATE_TYPE.STAND then
        istate = require("game.creature.machine.state.StandState").new()
    elseif self.m_currentState == MACHINE_STATE_TYPE.MOVE then
        istate = require("game.creature.machine.state.MoveState").new()
    elseif self.m_currentState == MACHINE_STATE_TYPE.ATTACK then
        istate = require("game.creature.machine.state.AttackState").new()
    elseif self.m_currentState == MACHINE_STATE_TYPE.HURT then
        istate = require("game.creature.machine.state.HurtState").new()
    elseif self.m_currentState == MACHINE_STATE_TYPE.DIE then
        istate = require("game.creature.machine.state.DieState").new()
    elseif self.m_currentState == MACHINE_STATE_TYPE.SKILL then
        istate = require("game.creature.machine.state.SkillState").new()
    end
    istate:init(self.m_creature)
end

return IStateMachine