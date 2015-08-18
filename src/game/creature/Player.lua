
local Player = class("Player",require("game/creature/BaseObject"))

function Player:ctor(data)
    self.super.ctor(self,data)
end

function Player:_overrideBaseObjectInit()
    self.currentWeapon = nil    -- 当前武器
    
    self.HP = 800
    
    self.machine = require("game/creature/machine/PlayerMachine").new()
    self.machine:init(self)
    self.machine:changeState(MACHINE_STATE_TYPE.STAND)
    
    local ai_type = self:getAttr(ATTR_DEFINE.AI_TYPE)
    self.ai = require("game.creature.machine.ai.AIFactory").getAI(ai_type)
    self.ai:init(self)
    
    self:setDirection(DIRECTION.RIGHT)
end

function Player:_overrideInitShadow()
    self.shadowEffect = global.effectMgr:createCommonEffect("1")
    self.m_bottomlayer:addChild(self.shadowEffect)
end

function Player:getHP()
    return self.HP
end
function Player:setHP(value)
    self.HP = value
end
function Player:getMaxHp()
    return 800
end

function Player:_overrideBaseObjectUpdate(duration, curTime)
    self.ai:handler()
end

function Player:setMoveDirection(dir,moveDir,actionName)
    local cState = self.machine:getCurrentState()
    if cState == MACHINE_STATE_TYPE.DIE then
        return
    end
    
    if dir>0 then
        self:setDirection(dir)
    end
    
    local isStand = false
    if cState ~=actionName then
        if actionName == MACHINE_STATE_TYPE.MOVE then
            self:changeActionState(actionName)
        elseif actionName == MACHINE_STATE_TYPE.STAND then
            self:changeActionState(actionName)
            isStand = true
        end
    end
    
    if isStand == true then 
        return
    end
	
    local speed = self:getAttr(ATTR_DEFINE.SPEED)
    
    local vx,vy = self:getPosition()
    
    local directionDir = self:getDirection()
    
	if moveDir == CREATURE_MOVE_DIR.RIGHT then
	   vx = vx+speed   
	elseif moveDir == CREATURE_MOVE_DIR.LEFT then
	   vx = vx-speed
	elseif moveDir == CREATURE_MOVE_DIR.UP then
	   vy = vy+speed
	elseif moveDir == CREATURE_MOVE_DIR.DOWN then
	   vy = vy-speed
	end
	
	local rect = global.mapMgr:getCurrentMoveSpeed()
--    print(rect.x,rect.y,rect.width,rect.height,vx)
	local inRectSign = global.commonFunc:checkPointInRect(cc.p(vx,vy),rect)
--    print("----->",inRectSign)
	if inRectSign == true then
	   self:setPosition(cc.p(vx,vy))
	else
        if vx > rect.width+rect.x or vx < rect.x then
            return
        end
        
        if directionDir == DIRECTION.LEFT  then
            vx = vx-speed   
        elseif directionDir == DIRECTION.RIGHT then
            vx = vx+speed
        end
        
        self:setPositionX(vx)
	end
	
	global.cameraMgr:updateMove()
end

function Player:_overrideBaseObjectAttackCall(i)
    combat_op.handlePlayerAttack(self)
end

function Player:_overrideActionComplete()
    self.machine:actionPlayCompleted()
end

function Player:changeActionState(state)
    self.machine:changeState(state)
end

function Player:getMachine()
    return self.machine
end

function Player:useSkillAttack(skillid)
	local  config = global.dataMgr:getConfigDatas("skill_config",skillid)
    local actionName = config.actionName
    local type = tonumber(config.type)
    local attack_range = tonumber(config.attack_range)
--    local icon = config.icon
    local effect = config.effect
    local cold_cd = tonumber(config.cold_cd)
    local attack_effect = config.attack_effect
--    local action_type = tonumber(config.action_type)
    
--    local vitro_type = tonumber(config.vitro_type)
    
    self:setAttr(ATTR_DEFINE.SKILLID,skillid)
    self:setAttr(ATTR_DEFINE.ACTION_NAME,actionName)
    self:setAttr(ATTR_DEFINE.SKILL_TYPE,type)
    self:setAttr(ATTR_DEFINE.ATTACK_RANGE,attack_range)
--    self:setAttr(ATTR_DEFINE.SKILL_ICON,icon)
    self:setAttr(ATTR_DEFINE.SKILL_EFFECT,effect)
    self:setAttr(ATTR_DEFINE.SKILL_COLD_CD,cold_cd)
    self:setAttr(ATTR_DEFINE.SKILL_BEATTACK_EFFECT,attack_effect)
--    self:setAttr(ATTR_DEFINE.SKILL_ACTION_TYPE,action_type)
    
--    if action_type == CREATURE_ATTACK_TYPE.ATTACK then
--        self:changeActionState(MACHINE_STATE_TYPE.ATTACK)
--    elseif action_type == CREATURE_ATTACK_TYPE.SKILL then
--        self:changeActionState(MACHINE_STATE_TYPE.SKILL)
--    end
    self:changeActionState(MACHINE_STATE_TYPE.SKILL)
end

--- 添加武器
function Player:_overrideAddWeaponFunc()
    if self.currentWeapon then
       return 
    end
    
    local model_id = self:getAttr(ATTR_DEFINE.MODEL_ID_X)
    local weapon_modelID = 2;
    local id = model_id.."_"..weapon_modelID
    local t = global.dataMgr:getConfigDatas("weapon_model",id)
    local pos = t["pos"]
    
    self.currentWeapon = global.objMgr:createWeaponByID(weapon_modelID)
--    self.currentWeapon:setAttr(ATTR_DEFINE.SKILLID,self:getAttr(ATTR_DEFINE.SKILLID))
    self.currentWeapon:setCreature(self)
    self.currentWeapon:setPosition(cc.p(tonumber(pos[1]),tonumber(pos[2])))
    self:getResCCB():addChild(self.currentWeapon)
    
--    self.currentWeapon = global.objMgr:createWeaponByID("1_1")
--    local node = self:getWeaponPos()
--    local vx,vy = node:getPosition()
--    self.currentWeapon:setPosition(cc.p(vx,vy))
--    self:getResCCB():addChild(self.currentWeapon)
end

function Player:getCurrentWeapon()
    return self.currentWeapon
end

--- 卸载武器
function Player:removeWeapon()
	if self.currentWeapon then
	   self.currentWeapon:clear()
	   self.currentWeapon:removeFromParent()
	end
    self.currentWeapon = nil
end

function Player:pause()
    if self.ai then
        self.ai:pause()
    end
    self.super.pause(self)
end

function Player:resume()
    if self.ai then
        self.ai:resume()
    end
    self.super.resume(self)
end

function Player:clear()
	if self.ai then
	   self.ai:clear()
	end
end

return Player