--
-- Author: dawn
-- Date: 2014-09-29 16:46:59
--
local BaseObject = class("BaseObject",function ( )
    return cc.Layer:create()
end)

function BaseObject:ctor(data)
	self.m_data = data
	self.m_bottomlayer = nil						--分层
	self.m_centerLayer = nil
	self.m_topLayer = nil			
	self.m_ccb = nil								--模型
	self.m_ccbAnimationMgr = nil					--模型动作管理
	self.m_shadow = nil
	self.m_direction = nil							--朝向
	self.m_attackCollider = nil							--攻击碰撞区
	self.m_beAttackedCollider = nil						--被击碰撞区
	self.m_sprite = nil
	self.m_weapon_pos = nil                          -- 武器坐标
	self.m_action = nil
	self.m_isPause = false
	
	self.machine = nil                             ---状态机
end

function BaseObject:init()
	--初始化三个层
    self.m_bottomlayer = cc.Node:create()
    self.m_centerLayer = cc.Node:create()
    self.m_topLayer = cc.Node:create()
	self:addChild(self.m_bottomlayer)
	self:addChild(self.m_centerLayer)
	self:addChild(self.m_topLayer)

	self:_initCCB()
	self:_initShadow()
	
	self:_overrideBaseObjectInit()
end

function BaseObject:_initShadow()
	-- local path = "img/ui/zhandoujiemain/battle_shadow.png"
	-- self.m_shadow = display.newSprite(path)
	-- self.m_bottomlayer:addChild(self.m_shadow)
	
	self:_overrideInitShadow()
end

function BaseObject:_overrideInitShadow()
    
end

function BaseObject:_initCCB()
	local ccbres = nil
--	if self:getAttr(ATTR_DEFINE.TYPE) == CREATURE_TYPE.VITRO then
--		ccbres = global.pathMgr:getEffect(self:getAttr(ATTR_DEFINE.CCB))
--	else
--		ccbres = global.pathMgr:getCreature(self:getAttr(ATTR_DEFINE.CCB))
--	end

    ccbres = global.pathMgr:getCCB(self:getAttr(ATTR_DEFINE.CCB))
	
	local ccbObj = require("game.base.CCBObject").new(ccbres)
	for i = 1,10 do 
		ccbObj:setDocumentCallBacks("attack_" .. i,handler(i,handler(self,self._attackCall)))
	end
	
    ccbObj:setDocumentCallBacks("completed_func",handler(self,self._actionComplete))
    
    ccbObj:setDocumentCallBacks("add_weapon_func",handler(self,self._addWeaponFunc))
	
	self.m_ccb = ccbObj:loadCCBNode()
	
	local attack_collider = ccbObj:getDocumentNode("attack_collider")
	local beattack_collider = ccbObj:getDocumentNode("beattack_collider")
    local sprite = ccbObj:getDocumentNode("bullet_pos")
    
    local weapon_pos = ccbObj:getDocumentNode("weapon_pos")
    
	if attack_collider then
		self.m_attackCollider = attack_collider
	end

	if beattack_collider then
		self.m_beAttackedCollider = beattack_collider
	end

	if sprite then
		self.m_sprite = sprite
	end
	
	if weapon_pos then
        self.m_weapon_pos = weapon_pos
	end
	self.m_ccbAnimationMgr = ccbObj:getAnimationManager()

	self.m_centerLayer:addChild(self.m_ccb)
	
--	self:setScale(0.8)
end

function BaseObject:getResCCB()
	return self.m_ccb
end

function BaseObject:_overrideBaseObjectInit()
end

-- 帧刷新
function BaseObject:onUpdate(duration, curTime)
	if self.m_isPause == true then
        return
    end
	self:_overrideBaseObjectUpdate(duration, curTime)
end

function BaseObject:_overrideBaseObjectUpdate(duration, curTime)
	
end

function BaseObject:_attackCall(i)
	self:_overrideBaseObjectAttackCall(i)
end

function BaseObject:_overrideBaseObjectAttackCall(i)
--    print("attack"..i)
end

function BaseObject:_actionComplete()
	self:_overrideActionComplete()
end

function BaseObject:_overrideActionComplete()
    print("BaseObject timeline is completed play.")
end

function BaseObject:_addWeaponFunc()
	self:_overrideAddWeaponFunc()
end

function BaseObject:_overrideAddWeaponFunc()
--	print("add weapon......")
end

function BaseObject:getTopLayer()
	return self.m_topLayer
end

function BaseObject:getBottomLayer()
	return self.m_bottomlayer
end

function BaseObject:getSprite()
	return self.m_sprite
end

function BaseObject:getWeaponPos()
    return self.m_weapon_pos
end

-- 攻击区域
function BaseObject:getAttackCollision()
	return self.m_attackCollider
end

-- 被攻击区域
function BaseObject:getAttackedCollision()
    return self.m_beAttackedCollider
end

-- 排序 y周排序
function BaseObject:getDepth()
	return 100000-self:getPositionY()
end

function BaseObject:setZOrder(i)
	self:setLocalZOrder(i)
end

function BaseObject:getLocationX( )
	return self:getPositionX()
end

function BaseObject:getLocationY( )
	return self:getPositionY()
end

function BaseObject:setLocationXY(x,y)
	self:setPosition(x, y)
end

function BaseObject:getLocationXY( )
	return self:getPosition()
end

function BaseObject:setDirection(dir)
	self.m_direction = dir
	if dir == DIRECTION.LEFT and self.m_centerLayer:getScaleX() ~= -1 then
		self.m_centerLayer:setScaleX(-1)
	elseif dir == DIRECTION.RIGHT and self.m_centerLayer:getScaleX() ~= 1 then
		self.m_centerLayer:setScaleX(1)
	end
end

function BaseObject:getDirection()
	return self.m_direction
end

function BaseObject:setAction(action)
	self.m_action = action
	if self.m_ccbAnimationMgr then
		self.m_ccbAnimationMgr:runAnimationsForSequenceNamedTweenDuration(self.m_action,0) --0.3
	end
end

function BaseObject:getAction()
	return self.m_action
end

function BaseObject:setAttr(k,v)
	self.m_data:update(k,v)
end

function BaseObject:getAttr(k)
	return self.m_data:get(k)
end

function BaseObject:removeWeapon()
	
end

-------------暂停/还原开始-------------------

function BaseObject:pause()
    self.m_isPause = true
    cc.Director:getInstance():getActionManager():pauseTarget(self.m_ccb)
end

function BaseObject:resume()
    self.m_isPause = false
    cc.Director:getInstance():getActionManager():resumeTarget(self.m_ccb)
end

-------------暂停还原结束--------------------

function BaseObject:clear()
    
end

return BaseObject

