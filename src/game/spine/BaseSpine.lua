
local BaseSpine = class("BaseSpine",function ()
	return cc.Layer:create()
end)

function BaseSpine:ctor(data)
    self.m_data = data
    self.m_bottomlayer = nil                        --分层
    self.m_centerLayer = nil
    self.m_topLayer = nil           
    self.spines = nil
    self.m_shadow = nil
    self.m_direction = nil                          --朝向
    self.m_attackCollider = nil                         --攻击碰撞区
    self.m_beAttackedCollider = nil                     --被击碰撞区
    self.m_isPause = false
    self.machine = nil                             ---状态机
	self.super.ctor(self)
end

function BaseSpine:init()
    self.m_bottomlayer = cc.Node:create()
    self.m_centerLayer = cc.Node:create()
    self.m_topLayer = cc.Node:create()
    self:addChild(self.m_bottomlayer)
    self:addChild(self.m_centerLayer)
    self:addChild(self.m_topLayer)
    
    self:_initSpine()
    self:_initShadow()

    self:_overrideBaseSpineInit()
end

function BaseSpine:_overrideBaseSpineInit()
	
end

function BaseSpine:_initSpine()
    local jpath = self:getAttr(ATTR_DEFINE.SPINE_JSON_STR) -- ceshi.json
    jpath = "spine/"..jpath
    local arlspath = self:getAttr(ATTR_DEFINE.SPINE_ALAS_STR) -- ceshi.atlas
    arlspath = "spine/"..arlspath
    
--    local s = sp.SkeletonAnimation:create("spine/ceshi.json", "spine2/ceshi.atlas")
    self.spines = sp.SkeletonAnimation:create(jpath,arlspath)
    self.m_centerLayer:addChild(self.spines)
    
    self.spines:registerSpineEventHandler(handler(self,self._startPlayFunc),sp.EventType.ANIMATION_START)
    self.spines:registerSpineEventHandler(handler(self,self._completeFunc),sp.EventType.ANIMATION_COMPLETE)
    self.spines:registerSpineEventHandler(handler(self,self._playEndFunc),sp.EventType.ANIMATION_END)
    self.spines:registerSpineEventHandler(handler(self,self._playEventFunc),sp.EventType.ANIMATION_EVENT)
end

function BaseSpine:_startPlayFunc(event)
    print(string.format("[spine] %d start: %s", 
        event.trackIndex,
        event.animation))
end

function BaseSpine:_completeFunc(event)
    print(string.format("[spine] %d complete: %d", 
        event.trackIndex, 
        event.loopCount))
end

function BaseSpine:_playEndFunc(event)
    print(string.format("[spine] %d end:", 
        event.trackIndex))
end

function BaseSpine:_playEventFunc(event)
    print(string.format("[spine] %d event: %s, %d, %f, %s", 
        event.trackIndex,
        event.eventData.name,
        event.eventData.intValue,
        event.eventData.floatValue,
        event.eventData.stringValue))
end

function BaseSpine:_initShadow()
    -- local path = "img/ui/zhandoujiemain/battle_shadow.png"
    -- self.m_shadow = display.newSprite(path)
    -- self.m_bottomlayer:addChild(self.m_shadow)

    self:_overrideInitShadow()
end

function BaseSpine:getSpine()
	return self.spines
end

function BaseSpine:_overrideInitShadow()

end

-- 帧刷新
function BaseSpine:onUpdate(duration, curTime)
    if self.m_isPause == true then
        return
    end
    self:_overrideBaseSpineUpdate(duration, curTime)
end

function BaseSpine:_overrideBaseSpineUpdate(duration, curTime)

end

function BaseSpine:getTopLayer()
    return self.m_topLayer
end

function BaseSpine:getBottomLayer()
    return self.m_bottomlayer
end

function BaseSpine:getAttackCollision()
    return self.m_attackCollider
end

-- 被攻击区域
function BaseSpine:getAttackedCollision()
    return self.m_beAttackedCollider
end

-- 排序 y周排序
function BaseSpine:getDepth()
    return 100000-self:getPositionY()
end

function BaseSpine:setZOrder(i)
    self:setLocalZOrder(i)
end

function BaseSpine:getLocationX( )
    return self:getPositionX()
end

function BaseSpine:getLocationY( )
    return self:getPositionY()
end

function BaseSpine:setLocationXY(x,y)
    self:setPosition(x, y)
end

function BaseSpine:getLocationXY()
    return self:getPosition()
end

function BaseSpine:setDirection(dir)
    self.m_direction = dir
    if dir == DIRECTION.LEFT and self.m_centerLayer:getScaleX() ~= -1 then
        self.m_centerLayer:setScaleX(-1)
    elseif dir == DIRECTION.RIGHT and self.m_centerLayer:getScaleX() ~= 1 then
        self.m_centerLayer:setScaleX(1)
    end
end

function BaseSpine:getDirection()
    return self.m_direction
end

function BaseSpine:setAction(action,isPlay)
    self.m_action = action
--    if self.m_ccbAnimationMgr then
--        self.m_ccbAnimationMgr:runAnimationsForSequenceNamedTweenDuration(self.m_action,0) --0.3
--    end
    
--    setAnimation(0, "stand01",true)
    --    skeletonNode:setMix("walk", "jump", 0.2)

    --    skeletonNode:addAnimation(0, "jump", false, 3)
    --    skeletonNode:addAnimation(0, "run", true)
    --    skeletonNode:setTimeScale(0.3) -- 控制时间轴播放快慢
    self.spines:setAnimation(0, action,isPlay)
end

function BaseSpine:getAction()
    return self.m_action
end

function BaseSpine:setAttr(k,v)
    self.m_data:update(k,v)
end

function BaseSpine:getAttr(k)
    return self.m_data:get(k)
end

-------------暂停/还原开始-------------------

function BaseSpine:pause()
    self.m_isPause = true
    cc.Director:getInstance():getActionManager():pauseTarget(self.spines)
end

function BaseSpine:resume()
    self.m_isPause = false
    cc.Director:getInstance():getActionManager():resumeTarget(self.m_ccb)
end

-------------暂停还原结束--------------------

function BaseSpine:clear()
	
end
