local BezierTest = class("BezierTest",function ()
	return cc.Layer:create()
end)

function BezierTest:ctor()
	self:_init()
end

function BezierTest:_init()
    self.drawnNode = cc.DrawNode:create()
    self:addChild(self.drawnNode)
    
	self:_initTest()
end

function BezierTest:_initTest()
    self.p_0 = cc.LayerColor:create(cc.c4b(0,0,0,255))
    self:setLayerParm(self.p_0)
    self.p_0:setPosition(center_x,center_y)
    self:addChild(self.p_0)

    self.p_1 = cc.LayerColor:create(cc.c4b(255,0,0,255))
    self:setLayerParm(self.p_1)
    self.p_1:setPosition(center_x + 100,center_y + 20)
    self:addChild(self.p_1)

    self.p_2 = cc.LayerColor:create(cc.c4b(0,255,0,255))
    self:setLayerParm(self.p_2)
    self.p_2:setPosition(center_x + 120,center_y - 20)
    self:addChild(self.p_2)

    self.p_3 = cc.LayerColor:create(cc.c4b(0,0,255,255))
    self:setLayerParm(self.p_3)
    self.p_3:setPosition(center_x + 100,center_y + 100)
    self:addChild(self.p_3)

    self.block = cc.LayerColor:create(cc.c4b(13,32,25,255))
    self:setLayerParm(self.block)
    self:addChild(self.block)

    self.t = 0
    self.firstpoint = cc.p(self.p_0:getPosition())

    local function onBegan(touch,event)
        local target = event:getCurrentTarget()
        local locationInNode = target:convertToNodeSpace(touch:getLocation())
        local s = target:getContentSize()
        local rect = cc.rect(0, 0, s.width, s.height)

        if cc.rectContainsPoint(rect, locationInNode) then
            return true
        end
        return false
    end
    local function onMoved(touch,event)
        local target = event:getCurrentTarget()
        local pos = touch:getLocation()
        target:setPosition(pos.x,pos.y)
    end
    local function onEnd(touch,event)
        self.t = 0
        self.drawnNode:clear()
        self.firstpoint = cc.p(self.p_0:getPosition())
    end

    local touchOneByOneListener = cc.EventListenerTouchOneByOne:create()
    touchOneByOneListener:setSwallowTouches(true) --- 阻止事件向下传递
    touchOneByOneListener:registerScriptHandler(onBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    touchOneByOneListener:registerScriptHandler(onMoved,cc.Handler.EVENT_TOUCH_MOVED)
    touchOneByOneListener:registerScriptHandler(onEnd,cc.Handler.EVENT_TOUCH_ENDED )

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(touchOneByOneListener:clone(),self.p_0)
    eventDispatcher:addEventListenerWithSceneGraphPriority(touchOneByOneListener:clone(),self.p_1)
    eventDispatcher:addEventListenerWithSceneGraphPriority(touchOneByOneListener:clone(),self.p_2)
    eventDispatcher:addEventListenerWithSceneGraphPriority(touchOneByOneListener:clone(),self.p_3)
end

function BezierTest:setLayerParm(l)
    l:setAnchorPoint(cc.p(0.5,0.5))
    l:setContentSize(cc.size(20,20))
    l:ignoreAnchorPointForPosition(false)
end
function BezierTest:_test()
    if self.t>1 then
        return
    end
    local p0 = cc.p(self.p_0:getPosition())
    local p1 = cc.p(self.p_1:getPosition())
    local p2 = cc.p(self.p_2:getPosition())
    local p3 = cc.p(self.p_3:getPosition())

    self.t = self.t + 0.01
    local bt = global.commonFunc:getThreeBezierPt(p0,p1,p2,p3,self.t)
    self.drawnNode:drawSegment(self.firstpoint,bt,1,cc.c4f(0.3, 0.2, 0.3, 1.0))
    self.firstpoint = bt

    self.block:setPosition(bt.x,bt.y)
end

return BezierTest