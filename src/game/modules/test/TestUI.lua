--
-- Author: dawn
-- Date: 2014-09-28 19:27:22
--
local TestUI = class("TestUI", require("game.base.BaseLayer"))


function TestUI:ctor()
	self.super.ctor(self)
	
--	self:_init()
    self:_initTest()
end

function TestUI:_initTest()
    self:setAccelerometerEnabled(true)
    
    local sp = cc.Sprite:create("imgs/img_mingzi_bg.png")
    sp:setPosition(cc.p(center_x,center_y))
    self:addChild(sp)
    
    local function accelerometerListener(event,x,y,z,timestamp)
        local target  = event:getCurrentTarget()
        local ballSize = target:getContentSize()
        local ptNowX,ptNowY    = target:getPosition()
        ptNowX = ptNowX + x * 9.81
        ptNowY = ptNowY + y * 9.81

        local minX  = math.floor(VisibleRect:left().x + ballSize.width / 2.0)
        local maxX  = math.floor(VisibleRect:right().x - ballSize.width / 2.0)
        if ptNowX <   minX then
            ptNowX = minX
        elseif ptNowX > maxX then
            ptNowX = maxX
        end

        local minY  = math.floor(VisibleRect:bottom().y + ballSize.height / 2.0)
        local maxY  = math.floor(VisibleRect:top().y   - ballSize.height / 2.0)
        if ptNowY <   minY then
            ptNowY = minY
        elseif ptNowY > maxY then
            ptNowY = maxY
        end

        target:setPosition(cc.p(ptNowX , ptNowY))
    end
    
    local listerner  = cc.EventListenerAcceleration:create(accelerometerListener)
 
    self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listerner,sp)
    
--    local par = global.commonFunc:getParticleSystems("images/effect/bubble_01.plist")
--    par:setPosition(center_x,center_y)
--    self:addChild(par)
end

function TestUI:_init()
--	self:_test()
    local layer = cc.Layer:create()
    self:addChild(layer)
    node_touchEvent(layer,handler(self,self._beganFunc),handler(self,self._moveFunc),handler(self,self._endFunc),nil)
    
    self:_testFn()
end

function TestUI:_testHttp()
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("POST","http://localhost:8080/GameServer/GameServlet",true)
--    xhr:open("POST","http://123.57.38.63:8080/GameServer/GameServlet",true)
--    xhr:open("POST","http://httpbin.org/post")
    
    local function onReadyStateChange()
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
--            labelStatusCode:setString("Http Status Code:"..xhr.statusText)
            print("Http Status Code:"..xhr.statusText)
            local response   = xhr.response
            local output = json.decode(response,1)
            table.foreach(output,function(i, v) print (i, v) end)
--            print("headers are")
--            table.foreach(output.headers,print)
        else
            print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
        end
    end
    
    xhr:registerScriptHandler(onReadyStateChange)
    local t = {moduleID = 10001,messageid = 1,data = "test"}
    t = json.encode(t)
    xhr:send(t)
end

function TestUI:_test()
    local par = global.commonFunc:getParticleSystems("111111.plist")
    par:setPosition(define_centerx,define_h)
    self:addChild(par)
    
    self.t = {}
    for i=1,5 do
        local c = global.objMgr:createCreatureByProto("1_1")
        c:setPosition(define_centerx/i,define_centery/i)
        c:setDirection(DIRECTION.LEFT)
        self.t[i] = c
    end
    
    local layer = cc.Layer:create()
    self:addChild(layer)
    node_touchEvent(layer,handler(self,self._beganFunc),handler(self,self._moveFunc),handler(self,self._endFunc),nil)
    
--    self.player = c
--    self.player:setDirection(DIRECTION.LEFT)
end

function TestUI:_beganFunc(touch,event)
	print(".....")
--    self.player:changeActionState(MACHINE_STATE_TYPE.ATTACK)
--    self.player:setAction(CREATURE_ACTION_NAME.MOVE)
--    self.player:useSkillAttack("2");
--    for key, var in pairs(self.t) do
--        local rid = math.random(1,5)
--        var:useSkillAttack(rid .. "")
--    end
    
    self:_testHttp()
	return false
end

function TestUI:_moveFunc(touch,event)
    
end
function TestUI:_endFunc(touch,event)
    
end

function TestUI:_testFn()
--    local sp = cc.Sprite:create("test.jpg")
--    sp:setAnchorPoint(cc.p(0,0))
--    self:addChild(sp)
end

return TestUI