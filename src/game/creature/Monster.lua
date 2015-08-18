
local Monster = class("Monster",require("game/creature/BaseObject"))

function Monster:ctor(data)
    self.super.ctor(self,data)
end

function Monster:_overrideBaseObjectInit()
    self.HP = 100
    
    self.machine = require("game.creature.machine.MonsterMachine").new()
    self.machine:init(self)
    self.machine:changeState(MACHINE_STATE_TYPE.STAND)
    
    local ai_type = self:getAttr(ATTR_DEFINE.AI_TYPE)
    self.ai = require("game.creature.machine.ai.AIFactory").getAI(ai_type)
    self.ai:init(self)
    
    self:setDirection(DIRECTION.LEFT)
    
--   self:setScale(1.5)
end

function Monster:getAI()
	return self.ai
end

function Monster:changeActionState(state)
	self.machine:changeState(state)
end

function Monster:getMachine()
	return self.machine
end

function Monster:_overrideBaseObjectUpdate(duration, curTime)
    self.ai:handler()
end

function Monster:getMaxHp()
	return 100
end

function Monster:getHP()
    return self.HP
end

function Monster:setHP(value)
    self.HP = value
end

--function Monster:setDirection(dir)
--    self.m_direction = dir
--    if dir == DIRECTION.LEFT and self.m_centerLayer:getScaleX() ~= 1 then
--        self.m_centerLayer:setScaleX(1)
--    elseif dir == DIRECTION.RIGHT and self.m_centerLayer:getScaleX() ~= -1 then
--        self.m_centerLayer:setScaleX(-1)
--    end
--end

function Monster:_overrideBaseObjectAttackCall(i)
    combat_op.handleMonsterAttack(self)
end

function Monster:_overrideActionComplete()
    self.machine:actionPlayCompleted()
end

function Monster:_overrideAddWeaponFunc()
    if self.currentWeapon then
        return 
    end 

    self.currentWeapon = global.objMgr:createWeaponByID("1_1")
    local node = self:getWeaponPos()
    local vx,vy = node:getPosition()
    self.currentWeapon:setPosition(cc.p(vx,vy))
    self:getResCCB():addChild(self.currentWeapon)
end

function Monster:getCurrentWeapon()
    return self.currentWeapon
end

--- 卸载武器
function Monster:removeWeapon()
    if self.currentWeapon then
        self.currentWeapon:clear()
        self.currentWeapon:removeFromParent()
    end
    self.currentWeapon = nil
end

function Monster:useSkillAttack(skillid)
--    local  config = global.dataMgr:getConfigDatas("skill_config",skillid)
--    local actionName = config.actionName
--    local type = tonumber(config.type)
--    local attack_range = tonumber(config.attack_range)
--    local icon = config.icon
--    local effect = config.effect
--    local cold_cd = tonumber(config.cold_cd)
--    local attack_effect = config.attack_effect
--    local action_type = tonumber(config.action_type)
--
--    self:setAttr(ATTR_DEFINE.SKILLID,skillid)
--    self:setAttr(ATTR_DEFINE.ACTION_NAME,actionName)
--    self:setAttr(ATTR_DEFINE.SKILL_TYPE,type)
--    self:setAttr(ATTR_DEFINE.ATTACK_RANGE,attack_range)
--    self:setAttr(ATTR_DEFINE.SKILL_ICON,icon)
--    self:setAttr(ATTR_DEFINE.SKILL_EFFECT,effect)
--    self:setAttr(ATTR_DEFINE.SKILL_COLD_CD,cold_cd)
--    self:setAttr(ATTR_DEFINE.SKILL_BEATTACK_EFFECT,attack_effect)
--    self:setAttr(ATTR_DEFINE.SKILL_ACTION_TYPE,action_type)
--    
--    if action_type == CREATURE_ATTACK_TYPE.ATTACK then
--        self:changeActionState(MACHINE_STATE_TYPE.ATTACK)
--    elseif action_type == CREATURE_ATTACK_TYPE.SKILL then
--        self:changeActionState(MACHINE_STATE_TYPE.SKILL)
--    end
    
    local  config = global.dataMgr:getConfigDatas("skill_config",skillid)
    local actionName = config.actionName
    local type = tonumber(config.type)
    local attack_range = tonumber(config.attack_range)
    local effect = config.effect
    local cold_cd = tonumber(config.cold_cd)
    local attack_effect = config.attack_effect

    self:setAttr(ATTR_DEFINE.SKILLID,skillid)
    self:setAttr(ATTR_DEFINE.ACTION_NAME,actionName)
    self:setAttr(ATTR_DEFINE.SKILL_TYPE,type)
    self:setAttr(ATTR_DEFINE.ATTACK_RANGE,attack_range)
    self:setAttr(ATTR_DEFINE.SKILL_EFFECT,effect)
    self:setAttr(ATTR_DEFINE.SKILL_COLD_CD,cold_cd)
    self:setAttr(ATTR_DEFINE.SKILL_BEATTACK_EFFECT,attack_effect)

    self:changeActionState(MACHINE_STATE_TYPE.SKILL)
end

function Monster:pause()
    if self.ai then
        self.ai:pause()
    end
    self.super.pause(self)
end

function Monster:resume()
    if self.ai then
        self.ai:resume()
    end
    self.super.resume(self)
end

function Monster:clear()
    if self.ai then
        self.ai:clear()
    end
end

return Monster