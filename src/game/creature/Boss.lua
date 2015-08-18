
local Boss = class("Boss",require("game.creature.BaseObject"))

function Boss:ctor(data)
	self.super.ctor(self,data)
end

function Boss:_overrideBaseObjectInit()
    self.HP = 150
    
    self.machine = require("game/creature/machine/BossMachine").new()
    self.machine:init(self)
    self.machine:changeState(MACHINE_STATE_TYPE.STAND)
    
--    self.ai = require("game/creature/machine/ai/BossAI").new()
--    self.ai:init(self)
    
    local ai_type = self:getAttr(ATTR_DEFINE.AI_TYPE)
    self.ai = require("game.creature.machine.ai.AIFactory").getAI(ai_type)
    self.ai:init(self)

    self:setDirection(DIRECTION.RIGHT)
end

function Boss:getAI()
    return self.ai
end

function Boss:changeActionState(state)
    self.machine:changeState(state)
end

function Boss:getMachine()
    return self.machine
end 

function Boss:_overrideBaseObjectUpdate(duration, curTime)
    self.ai:handler()
end

function Boss:getMaxHp()
    return 150
end

function Boss:getHP()
    return self.HP
end

function Boss:setHP(value)
    self.HP = value
end

function Boss:_overrideBaseObjectAttackCall(i)
    combat_op.handleBossAttack(self)
end

function Boss:_overrideActionComplete()
    self.machine:actionPlayCompleted()
end

function Boss:useSkillAttack(skillid)
    local  config = global.dataMgr:getConfigDatas("skill_config",skillid)
    local actionName = config.actionName
    local type = tonumber(config.type)
    local attack_range = tonumber(config.attack_range)
    local icon = config.icon
    local effect = config.effect
    local cold_cd = tonumber(config.cold_cd)
    local attack_effect = config.attack_effect
    local action_type = tonumber(config.action_type)

    self:setAttr(ATTR_DEFINE.SKILLID,skillid)
    self:setAttr(ATTR_DEFINE.ACTION_NAME,actionName)
    self:setAttr(ATTR_DEFINE.SKILL_TYPE,type)
    self:setAttr(ATTR_DEFINE.ATTACK_RANGE,attack_range)
    self:setAttr(ATTR_DEFINE.SKILL_ICON,icon)
    self:setAttr(ATTR_DEFINE.SKILL_EFFECT,effect)
    self:setAttr(ATTR_DEFINE.SKILL_COLD_CD,cold_cd)
    self:setAttr(ATTR_DEFINE.SKILL_BEATTACK_EFFECT,attack_effect)
    self:setAttr(ATTR_DEFINE.SKILL_ACTION_TYPE,action_type)

    if action_type == CREATURE_ATTACK_TYPE.ATTACK then
        self:changeActionState(MACHINE_STATE_TYPE.ATTACK)
    elseif action_type == CREATURE_ATTACK_TYPE.SKILL then
        self:changeActionState(MACHINE_STATE_TYPE.SKILL)
    end
    
    -- 武器 攻击动作 切换武器 释放子弹 
    -- 
end

function Boss:pause()
    if self.ai then
        self.ai:pause()
    end
    self.super.pause(self)
end

function Boss:resume()
    if self.ai then
        self.ai:resume()
    end
	self.super.resume(self)
end

function Boss:clear()
    if self.ai then
        self.ai:clear()
    end
end

return Boss