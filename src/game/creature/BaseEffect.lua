--基础特效类
local BaseEffect = class("BaseEffect",function() 
--	return cc.Layer:create()
    return cc.Node:create()
end)

function BaseEffect:ctor(id,parent,creature)
	self.m_ccbInfo = nil
	self.m_id = id
	self.m_state = nil
	self.m_parent = parent
	self.m_creature = creature
	self.m_posx = 0
	self.m_posy = 0
	self.m_ccb = nil
	self.m_animationMgr = nil

	self.beginCallbacks = {}
	self.endCallbacks = {}
	self.m_attackCollider = nil

    self.m_ccbInfo = global.dataMgr:getConfigDatas("effect_config",id)
	self:setContentSize(cc.size(0,0))
	
	self.m_isPause = false
	
--    self:_setEffectType(self.m_ccbInfo.type)
	self:_init()
end

function BaseEffect:_init()
    local info = self.m_ccbInfo
	local ccbObj = require("game.base.CCBObject").new(global.pathMgr:getEffect(self.m_ccbInfo.effectName))
	for i = 1,10 do 
		ccbObj:setDocumentCallBacks("attack_" .. i,handler(i,handler(self,self._attackCall)))
	end
	
    ccbObj:setDocumentCallBacks("completed_func",handler(self,self._actionComplete))
    
    ccbObj:setDocumentCallBacks("shot_zidan_func",handler(self,self._shotZiDanFunc))
    
	self.m_ccb = ccbObj:loadCCBNode()
	self.m_animationMgr = ccbObj:getAnimationManager()
	self:addChild(self.m_ccb)

	local attack_collider = ccbObj:getDocumentNode("attack_collider")
	if attack_collider then
		self.m_attackCollider = attack_collider
	end

	self.m_state = EFFECT_STATE.WAIT
end

function BaseEffect:setEffectType(type)
	self.m_effect_type = type
end

function BaseEffect:getEffectType()
    return self.m_effect_type
end

-- 排序 y周排序
function BaseEffect:getDepth()
	return 100000-self:getPositionY()
end

function BaseEffect:setZOrder(i)
    self:setLocalZOrder(i)
end

function BaseEffect:update(duration, curTime)
    if self.m_isPause == true then
        return
    end
    
	self:_overrideUpdate(duration, curTime)
end

function BaseEffect:_overrideUpdate( duration, curTime )
    
end

function BaseEffect:_shotZiDanFunc()
	self:_overrideShotZiDanFunc()
end
function BaseEffect:_overrideShotZiDanFunc()
    combat_op.handlerShotZiDanFunc(self)
end

function BaseEffect:_attackCall(i)
	self:_overBaseAttackFn(i)
end

function BaseEffect:_actionComplete()
	self:_overrideActionComplete()
end

function BaseEffect:_overrideActionComplete()
    print("BaseEffect timeline is completed play.")
end

function BaseEffect:_overBaseAttackFn(i)
--	combat_op.handleAttackByAirto(self,i)
end

function BaseEffect:getAttackCollision()
	return self.m_attackCollider
end

--播放
function BaseEffect:play()
	self.m_parent:addChild(self)
	self:setPosition(cc.p(self.m_posx,self.m_posy))
	self.m_state = EFFECT_STATE.READY
	self:_overrideBaseEffectPlay()
end

function BaseEffect:_overrideBaseEffectPlay()
	
end

--销毁
function BaseEffect:dispose()
	self.m_state = EFFECT_STATE.RUBBISH
end


--注册开始回调函数 , 开始播放前注册函数
function BaseEffect:registerBeginCallback(f,p)
	for i = 1,#self.beginCallbacks do
		if self.beginCallbacks[i].fun == f and self.beginCallbacks[i].params == p then
			return
		end
	end
	table.insert(self.beginCallbacks,{
										fun = f,
										params = p
									})
end

--注册结束回调函数(播放一次的特效  循环播放的特效 此函数无效)
function BaseEffect:registerEndCallback(f,p)
	for i = 1,#self.endCallbacks do
		if self.endCallbacks[i].fun == f and self.endCallbacks[i].params == p then
			return
		end
	end
	table.insert(self.endCallbacks,{
										fun = f,
										params = p
									})
end

--执行回调函数   该函数在effect_manager中的渲染函数中调用
function BaseEffect:renderCallbacks(type)
	local callbacks
	if type == EFFECT_CALLBACK.BEGIN then
		callbacks = self.beginCallbacks
	elseif type == EFFECT_CALLBACK.END then
		callbacks = self.endCallbacks
	end
	for i = #callbacks,1,-1 do
		callbacks[i].fun(callbacks[i].params)
		table.remove(callbacks,i)
	end
end

function BaseEffect:getState()
	return self.m_state
end

function BaseEffect:setState(state)
	self.m_state = state
end

function BaseEffect:setDirection(dir)
	self.m_direction = dir
	if dir == DIRECTION.LEFT and self:getScaleX() ~= -1 then
		self:setScaleX(-1)
	elseif dir == DIRECTION.RIGHT and self:getScaleX() ~= 1 then
		self:setScaleX(1)
	end
end

function BaseEffect:getDirection()
	return self.m_direction
end

function BaseEffect:getOwner()
	return self.m_creature
end

--判断特效是否在播放
function BaseEffect:isRunning()
	--如果c++对象被删除 则返回nil
	if tolua.isnull(self) then
		return nil
	end
	
	if self:getAnimationManager():getRunningSequenceName() ~= nil then
		return true
	end

	return false
end

function BaseEffect:pause()
    self.m_isPause = true 
    cc.Director:getInstance():getActionManager():pauseTarget(self.m_ccb)
end

function BaseEffect:resume()
    self.m_isPause = false 
    cc.Director:getInstance():getActionManager():resumeTarget(self.m_ccb)
end

function BaseEffect:getAnimationManager()
	return self.m_animationMgr
end

function BaseEffect:setDefineData(data)
	self.m_define_data = data
end

function BaseEffect:getDefineData()
	return self.m_define_data
end

function BaseEffect:clear()

end

return BaseEffect