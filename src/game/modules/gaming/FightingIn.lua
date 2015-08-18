
local FightingIn = class("FightingIn",function ()
	return cc.Layer:create()
end)

local barryFac = require("game.modules.gaming.barry.BarryFac")

local BALL_SHOT_SPEED = 0.03            -- 小球发射速度
local WALL_REBOUND_SPEED = 1000         -- 墙壁碰撞速度
local BALL_REBOUND_SPEED = 500          -- 小球碰撞速度
local TRA_REBOUND_SPEED = 200           -- 梯形碰撞速度
local TRIANGLE_REBOUND_SPEED = 200      -- 三角形碰撞速度
local RECT_REBOUND_SPEED = 300          -- 方形碰撞速度

local QT_CIRCLE_SPEED = 500             -- 反弹圆形障碍物反弹速度
local QT_RECT_SPEED = 500               -- 反弹矩形障碍物反弹速度

function FightingIn:ctor(id)
    self.levelID = id or 1
    self.bodysDict = {}                          --- 所有碰撞合集
    
    self:_initParams()
    self:_init()
end

function FightingIn:_initParams()
    self.m_data = global.dataMgr:getConfigDatas("level_config",self.levelID)
    self.m_task_nums = 0
    self.beganCollisionSign = false             --- 控制是否开始碰撞检测
    self.ballShotSpeed = nil                    --- 小球发射速度
    self.ballStartPt = nil                      --- 小球发射的起点坐标
    self.top_ui = nil                         --- 顶部UI
    self.touchLayer = nil                       --- 触摸事件
    self.framehandler = nil                     --- 帧更新句柄
    self.world = nil                            --- 物理世界
    self.tankAngle = 0                          --- 高炮台旋转角度
    self.tank = nil                             --- 炮台
    self.goldPotSpeed = 5                       --- 底部宝葫芦移动速度
    self.hiddenGoldPot = false                  --- 隐藏宝葫芦状态

    self.cr = BALL_G_RS                         --- 小球半径
    self.isShotBallSign = false                 --- 是否射击小球的状态
    self.ball_T = 0                             --- 小球运动时间
    self.L = 150                                --- 发射半径
    self.touchSign = true                       ---- 是否可以再次触摸状态
    self.isMoveTankSign = false                 --- 是否在移动
    self.sball = nil                            --- 当前小球
    self.clearBallDict = {}                     --- 要清除小球的集合
    self.tempScore = 0                          --- 小球得分    
    self.steps = 0                              --- 剩余球数
    
    self.dotLayer = nil                         --- 轨迹路径层 
    self.dotDicts = {}                          --- 存储路径

    -------- 测试代码 --------
--    self.drawNode = nil                         --- 绘制
end

function FightingIn:_init()
    self:_initPhysicWorld()     -- 物理世界
    self:_initBarWood()         -- 上，左右挡板
    self:_loadLevelInit()       -- 关卡布局
    self:_initTank()            -- 发射炮台
    self:_addShotBodyDot()      -- 小球引导路径
    self:_initGoldPot()         -- 宝葫芦
    self:_initBall()            -- 初始化小球
    self:_initBallNums()        -- 小球数量
    self:_addFightUI()          -- 战斗UI
    
    self:_registerFn()          -- 触摸事件
    self:_registerCollision()   -- 碰撞事件
    
    self:_testBlock()
end

function FightingIn:_initPhysicWorld()
    self.world = cc.Director:getInstance():getRunningScene():getPhysicsWorld()
--    self.world:setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
    self.world:setGravity(cc.p(0,0))
end
---------------------------------- 添加墙壁碰撞 ------------------------------------
function FightingIn:_initBarWood()
    self.leftBorder = cc.LayerColor:create(cc.c4b(0,0,0,255))
    self.leftBorder:setAnchorPoint(cc.p(0.5,0.5))
    self.leftBorder:setContentSize(cc.size(50,define_h)) 
    self.leftBorder:ignoreAnchorPointForPosition(false)
    self.leftBorder:setPosition(-50/2,define_centery)
    self:addChild(self.leftBorder,1)
    local body2 = barryFac.getBarry(BARRYS_TYPE.BARRY_WOOD,50,define_h,1)
    body2:bind(self.leftBorder)

    self.rightBorder = cc.LayerColor:create(cc.c4b(0,0,0,255))
    self.rightBorder:setAnchorPoint(cc.p(0.5,0.5))
    self.rightBorder:setContentSize(cc.size(50,define_h)) 
    self.rightBorder:ignoreAnchorPointForPosition(false)
    self.rightBorder:setPosition(define_right+50/2,define_centery) 
    self:addChild(self.rightBorder,1)
    local body = barryFac.getBarry(BARRYS_TYPE.BARRY_WOOD,50,define_h,1) 
    body:bind(self.rightBorder)

    self.topBorder = cc.LayerColor:create(cc.c4b(0,0,0,255))
    self.topBorder:setAnchorPoint(cc.p(0.5,0.5))
    self.topBorder:setContentSize(cc.size(define_w,50)) 
    self.topBorder:ignoreAnchorPointForPosition(false)
    self.topBorder:setPosition(define_centerx,define_top+50/2) 
    self:addChild(self.topBorder,1)
    local body = barryFac.getBarry(BARRYS_TYPE.BARRY_WOOD,define_w,50,2) 
    body:bind(self.topBorder)
end
function FightingIn:_loadLevelInit()
    local ccbname = self.m_data["ccb"]
    self.level_ui = require("game/base/LevelCCB.lua").new(ccbname)
    self.level_ui:initCCB()
    self:addChild(self.level_ui,1)

    self.bodysDict["circle"] = {}
    self.bodysDict["rect"] = {}
    self.bodysDict["ladder"] = {}
    self.bodysDict["triangle"] = {}
    self.bodysDict["rebound_circle"] = {}
    self.bodysDict["rebound_rect"] = {}
    
    local body,sp,str,color,sk
    local id = 1
    local dict = {}
    --- 圆形
    for i = 1,20 do 
        for k,v in pairs(BARRY_COLOR_NAME) do
            str = "circle_"..v.."_"..i
            sp = self.level_ui[str]
            if sp then
                color = BARRY_COLORS_TYPE[v]
                body = barryFac.getBarry(BARRYS_TYPE.BARRY_CIRCLE)
                body:setColor(color)
                body:bind(sp)
                body:setID(id)
                body:setKey("circle")
                id = id + 1

                if v == "red" then
                    self.m_task_nums = self.m_task_nums + 1
                end
                
                dict[i..""] = body
            end
        end
    end
    self.bodysDict["circle"] = dict
    
    dict = {}
    -- 方形
    for i=1,20 do
        for k,v in pairs(BARRY_COLOR_NAME) do
            str = "rect_"..v.."_"..i
            sp = self.level_ui[str]
            if sp then
                color = BARRY_COLORS_TYPE[v]
                body = barryFac.getBarry(BARRYS_TYPE.BARRY_RECT)
                body:setColor(color)
                body:bind(sp)
                body:setID(id)
                body:setKey("rect")
                id = id + 1

                if v == "red" then
                    self.m_task_nums = self.m_task_nums + 1
                end
                dict[i..""] = body
            end
        end
    end
    self.bodysDict["rect"] = dict
    
    dict = {}

    ----梯形
    sk = {cc.p(-66/2+5,-38/2+5),cc.p(-66/2+10,38/2),cc.p(66/2-10+2,38/2),cc.p(66/2-5,-38/2+5)}
    for i=1,20 do
        for k,v in pairs(BARRY_COLOR_NAME) do 
            str = "ladder_"..v.."_"..i
            sp = self.level_ui[str]
            if sp then
                color = BARRY_COLORS_TYPE[v]
                body = barryFac.getBarry(BARRYS_TYPE.BARRY_TRA)
                body:setTarPoint(sk)
                body:setColor(color)
                body:bind(sp)
                body:setID(id)
                body:setKey("ladder")
                id = id + 1

                if v == "red" then
                    self.m_task_nums = self.m_task_nums + 1
                end
                
                dict[i..""] = body
            end
        end
    end
    
    self.bodysDict["ladder"] = dict
    
    dict = {}

    ---三角形
    sk = {cc.p(-50/2+8,-38/2+5),cc.p(0,38/2-5),cc.p(50/2-8,-38/2+5)}
    for i=1,20 do 
        for k,v in pairs(BARRY_COLOR_NAME) do 
            str = "triangle_"..v.."_"..i
            sp = self.level_ui[str]
            if sp then
                color = BARRY_COLORS_TYPE[v]
                body = barryFac.getBarry(BARRYS_TYPE.BARRY_Triangle)
                body:setTrianglePoint(sk)
                body:setColor(color)
                body:bind(sp)
                body:setID(id)
                body:setKey("triangle")
                id = id + 1

                if v == "red" then
                    self.m_task_nums = self.m_task_nums + 1
                end
                
                dict[i..""] = body
            end
        end
    end
    
    self.bodysDict["triangle"] = dict
    
    dict = {}

    -- 其他
    for i=1,5 do 
        str = "rebound_circle_" .. i
        sp = self.level_ui[str]
        if sp then
            body = barryFac.getBarry(BARRYS_TYPE.BARRY_QT_CIRCLE)
            body:bind(sp)
            body:setKey("rebound_circle")
            
            dict[i..""] = body
        end
    end
    
    self.bodysDict["rebound_circle"] = dict
    
    dict = {}

    for i=1,15 do 
        str = "rebound_rect_" .. i
        sp = self.level_ui[str]
        if sp then
            body = barryFac.getBarry(BARRYS_TYPE.BARRY_QT_RECT)
            body:bind(sp)
            body:setKey("rebound_rect")
            
            dict[i..""] = body
        end
    end
    
    self.bodysDict["rebound_rect"] = dict
    dict = {}
end

function FightingIn:_addShotBodyDot()   --- 绘制发射路径
--    self.drawNode = cc.DrawNode:create()
--    self:addChild(self.drawNode,12)
    
    self.dotLayer = cc.Layer:create()
    self:addChild(self.dotLayer,12)
    self.dotDicts = {}
    
--    local dot_pos = {1,0.}
    for i=1,16 do 
        local path = global.pathMgr:getPicUI("line_dot")
        local dot = cc.Sprite:create(path)
        dot:setPosition(ps)
        self.dotLayer:addChild(dot)
        dot:setVisible(false)
        dot:setScale(i/15)
--        table.insert(self.dotDicts,dot)
        self.dotDicts[i] = dot
    end
    
end

function FightingIn:_removeLineDot()
    for key, var in pairs(self.dotDicts) do
--    	var:clear()
--        var:removeFromParent()
        var:setVisible(false)
    end
--    self.dotDicts = nil
--    self.dotDicts = {}
end

function FightingIn:_addLineDot()
    
end

function FightingIn:_initTank()
    local path = global.pathMgr:getFightImg("big_tank")
    self.tank = cc.Sprite:create(path)
    self:addChild(self.tank,4)
    self.tank:setPosition(define_centerx,define_top)
    self.tank:setRotation(self.tankAngle)
end
function FightingIn:_initGoldPot()
    local path,body
    path = global.pathMgr:getPicUI("baohualu_down")
    self.goalUp = cc.Sprite:create(path)
    self.goalUp:setPosition(define_centerx,define_bottom+30-10)
    self:addChild(self.goalUp,5)

    path = global.pathMgr:getPicUI("baohualu_up")
    self.goalDown = cc.Sprite:create(path)
    self.goalDown:setPosition(define_centerx,define_bottom+30-10)
    self:addChild(self.goalDown,10)

    local node_1 = cc.Node:create() -- 宝葫芦顶部
    body = barryFac.getBarry(BARRYS_TYPE.BARRY_LINEBODY,123,5)
    body:bind(node_1)
    self.goalDown:addChild(node_1)
    node_1:setPosition(120,36)
    
    local node_2 = cc.Node:create()
    body = barryFac.getBarry(BARRYS_TYPE.BARRY_GOAL,55,5)
    body:bind(node_2)
    self.goalDown:addChild(node_2)
    node_2:setPosition(25,20)
    node_2:setRotation(-50)

    local node_3 = cc.Node:create()
    body = barryFac.getBarry(BARRYS_TYPE.BARRY_GOAL,55,5)
    body:bind(node_3)
    self.goalDown:addChild(node_3)
    node_3:setPosition(225,20)
    node_3:setRotation(50)
    
    self.goalUp:setVisible(false)
    self.goalDown:setVisible(false)
end
function FightingIn:_initBall()
    self.sball = self:_getShotBall()
    self:_setBallPos()
end
function FightingIn:_initBallNums()
    self.steps = tonumber(self.m_data["balls"])
end
function FightingIn:_addFightUI()
    self.top_ui = require("game.modules.gaming.item.FightTopUI").new(self.levelID)
    self:addChild(self.top_ui,40)
end

function FightingIn:_registerFn()
    self.touchLayer = cc.Layer:create()
    node_touchEvent(self.touchLayer,handler(self,self._onBeganTouch),handler(self,self._onMoveTouch),handler(self,self._endTouch),nil)
    self:addChild(self.touchLayer,30)

    self.framehandler = SCHE_MGR.scheduleUpdateGlobal(handler(self,self._frameFunc))

    self:registerScriptHandler(function(event)
        if "exit" == event then
            if self.framehandler then
                SCHE_MGR.unscheduleGlobal(self.framehandler)
                self.framehandler = nil
            end
        end
    end)
    
    global.gamingMgr:registerFn(LEVEL_EVENT.UPDATE_TASK_BARRY_NUMS,handler(self,self._updateTaskNums))
    global.gamingMgr:registerFn(LEVEL_EVENT.RESTART_GAME,handler(self,self._restartGame))
    global.gamingMgr:registerFn(LEVEL_EVENT.CLICK_PROPS_EVENT,handler(self,self._clickProps))    
    global.gamingMgr:registerFn(LEVEL_EVENT.REMOVE_BODYS_EVENT,handler(self,self._removeBodys))
end

function FightingIn:_registerCollision()
    local contactListener = cc.EventListenerPhysicsContact:create()
    contactListener:registerScriptHandler(handler(self,self._onContactBegin), cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
    contactListener:registerScriptHandler(handler(self,self._onPreSove),cc.Handler.EVENT_PHYSICS_CONTACT_PRESOLVE)
    contactListener:registerScriptHandler(handler(self,self._onSeperate),cc.Handler.EVENT_PHYSICS_CONTACT_SEPERATE)
    --contactListener:registerScriptHandler(handler(self,self._onPostSolve),cc.Handler.EVENT_PHYSICS_CONTACT_POSTSOLVE)
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(contactListener, self)
end

function FightingIn:_restartGame()
    print("重新开始")
    
    global.popWndMgr:close(WND_NAME.FIGHTING_IN)
    global.popWndMgr:open(WND_NAME.FIGHTING_IN)    
end

function FightingIn:_clickProps()
    print("使用道具")
end

function FightingIn:_updateTaskNums()
    self.m_task_nums = self.m_task_nums -1
end

------------------------------------- 事件处理 --------------------------------------
function FightingIn:_onBeganTouch(touch,event)
    if not self.touchSign then
        return false
    end
    self.isMoveTankSign = false
    return true
end

function FightingIn:_onMoveTouch(touch,event)
    self.isMoveTankSign = true
    
    local cpt = touch:getLocation()
    if cpt.y > define_top then
        return
    end
    local prept = touch:getPreviousLocation()
    local preangle = self:_getTankAngle(prept)
    local cangle = self:_getTankAngle(cpt)
    local gapangle = cangle - preangle
    self.tankAngle = self.tankAngle + gapangle
    if self.tankAngle >=GOLD_BALL_MAX_DU  then
        self.tankAngle = GOLD_BALL_MAX_DU
    elseif self.tankAngle <= -GOLD_BALL_MAX_DU then
        self.tankAngle = -GOLD_BALL_MAX_DU
    end
    self.tank:setRotation(self.tankAngle)
    if self.sball then
        self:_setBallPos()
    end
end

function FightingIn:_endTouch(touch,event)
    if not self.isMoveTankSign then
        self:_shotSball()
    end
end
---------- 碰撞处理 -------
function FightingIn:_onContactBegin(contact) -- 第一次碰撞
    if not self.beganCollisionSign then
        return false
    end
    
    local a = contact:getShapeA():getBody()
    local b = contact:getShapeB():getBody()
    local preContactData = contact:getPreContactData():getContactData()
    local contactData = contact:getContactData()
    local pts = contactData.points
    local aType = a:getType()
    local bType = b:getType()

    if aType == BARRYS_TYPE.BARRY_LINEBODY or bType == BARRYS_TYPE.BARRY_LINEBODY then
        self.isEnterBall = true
--        global.gamingMgr:applyFn(LEVEL_EVENT.COLLISION_EVENTS,a,b,COLLISION_EVENT.BEGAIN)
        self.steps = self.steps + 1
        global.gamingMgr:applyFn(LEVEL_EVENT.UPDATE_STEP_NUMS,self.steps)
        return false
    end
    
    self.isEnterBall = false
    local body,body2
    if aType == BARRYS_TYPE.BALL_TYPE then
          body = a
          body2 = b
     elseif bType == BARRYS_TYPE.BALL_TYPE then
          body = b
          body2 = a
     end
     local ty = body2:getType()
     if ty == BARRYS_TYPE.BARRY_CIRCLE or ty == BARRYS_TYPE.BARRY_TRA or ty == BARRYS_TYPE.BARRY_RECT or ty == BARRYS_TYPE.BARRY_Triangle then
        local id = body2:getID()
        self.clearBallDict[id .. ""] = body2
     end
    
    local speeds = 1000
    if not self.sball or body:getGivitySign() == true then
        local xsign = false
        if aType == BARRYS_TYPE.BARRY_QT_CIRCLE or bType == BARRYS_TYPE.BARRY_QT_CIRCLE then
            speeds = QT_CIRCLE_SPEED
            xsign = true
        elseif aType == BARRYS_TYPE.BARRY_QT_RECT or bType == BARRYS_TYPE.BARRY_QT_RECT then
            speeds = QT_RECT_SPEED
            xsign = true      
        end
        if xsign == true then
            local pt2 = cc.p(pts[1].x,pts[1].y)
            local ptx,pty,v_x,v_y,ans
            local vp_x,vp_y = body:getNode():getPosition()
            ptx = pt2.x - vp_x
            pty = pt2.y - vp_y
            ans = math.atan(pty/ptx)
            v_x = speeds * math.cos(ans)
            v_y = speeds * math.sin(ans)
            
            local angs = ans*180/math.pi
            
            if vp_y > pt2.y then
                if angs<0 then
                    v_x = -v_x
                    v_y = -v_y
                end
            else
                if angs >0 then
                    v_x = -v_x
                    v_y = -v_y
                end
            end
            body:setVelocity(cc.p(v_x,v_y))
            return true
        end
        return true
    end
    if aType == BARRYS_TYPE.BARRY_WOOD or bType == BARRYS_TYPE.BARRY_WOOD then
         speeds = WALL_REBOUND_SPEED
    elseif aType == BARRYS_TYPE.BARRY_CIRCLE or bType == BARRYS_TYPE.BARRY_CIRCLE then
            speeds = BALL_REBOUND_SPEED
        elseif aType == BARRYS_TYPE.BARRY_RECT or bType == BARRYS_TYPE.BARRY_RECT then
            speeds = RECT_REBOUND_SPEED
        elseif aType == BARRYS_TYPE.BARRY_TRA or bType == BARRYS_TYPE.BARRY_TRA then
            speeds = TRA_REBOUND_SPEED
        elseif aType == BARRYS_TYPE.BARRY_Triangle or bType == BARRYS_TYPE.BARRY_Triangle then
            speeds = TRIANGLE_REBOUND_SPEED
        end
        local pt1 = self.ballStartPt
        local pt2 = cc.p(pts[1].x,pts[1].y)
        local ptx = pt1.x - pt2.x
        local pty = pt1.y - pt2.y
        local ans = math.atan(pty/ptx)
        local v_x = speeds * math.cos(ans)
        local v_y = speeds * math.sin(ans)
        
        self.isShotBallSign = false
        
        if aType == BARRYS_TYPE.BARRY_WOOD or bType == BARRYS_TYPE.BARRY_WOOD then
            if v_y >0 then
                v_y = -v_y
            else
                v_x = -v_x
            end
            body:setVeSpeed(v_x,v_y)
            body:setApplyForce()     
        else
            local vp_x,vp_y = body:getNode():getPosition()
            ptx = pt2.x - vp_x
            pty = pt2.y - vp_y
            ans = math.atan(pty/ptx)
            v_x = speeds * math.cos(ans)
            v_y = speeds * math.sin(ans)
            
            local angs = ans*180/math.pi
            if vp_y > pt2.y then
                if angs<0 then
                    v_x = -v_x
                    v_y = -v_y
                end
            else
                if angs >0 then
                    v_x = -v_x
                    v_y = -v_y
                end
            end
            body:setVeSpeed(v_x,v_y)
            body:setApplyForce()
        end
        return true
end

function FightingIn:_onPreSove(contact) -- 一直在接触
    local a = contact:getShapeA():getBody()
    local b = contact:getShapeB():getBody()
--    global.gamingMgr:applyFn(LEVEL_EVENT.COLLISION_EVENTS,a,b,COLLISION_EVENT.SOVE)
    self:_dealPhysicBodyCollisionEvent(a,b,COLLISION_EVENT.SOVE)
    return true
end
function FightingIn:_onSeperate(contact) -- 分离
    local a = contact:getShapeA():getBody()
    local b = contact:getShapeB():getBody()
--    global.gamingMgr:applyFn(LEVEL_EVENT.COLLISION_EVENTS,a,b,COLLISION_EVENT.SEPERATE)
    self:_dealPhysicBodyCollisionEvent(a,b,COLLISION_EVENT.SEPERATE)
    return true
end
function FightingIn:_dealPhysicBodyCollisionEvent(a,b,type)
    local atype = a:getType()
    local btype = b:getType()
    
    local body = nil
    if atype == BARRYS_TYPE.BALL_TYPE then
        body = b
    else
        body = a
    end

    if body then
        local cType = body:getType()
        local color = body:getColor()
        
        if cType == BARRYS_TYPE.BARRY_CIRCLE or cType == BARRYS_TYPE.BARRY_RECT or cType == BARRYS_TYPE.BARRY_TRA or cType == BARRYS_TYPE.BARRY_Triangle then
            if type ~= COLLISION_EVENT.SEPERATE then
                body:collisionHandler()
                if color == BARRY_COLOR.NORMAL then
                    self:_normalBodyCollision(body)
                elseif color == BARRY_COLOR.BLUE then
                    self:_blueBodyCollision(body)
                elseif color == BARRY_COLOR.RED then
                    self:_redBodyCollision(body)
                elseif color == BARRY_COLOR.YELLOW then
                    self:_yellowCollision(body)
                end 
            end
        elseif cType == BARRYS_TYPE.BARRY_QT_RECT or cType == BARRYS_TYPE.BARRY_QT_RECT then
            if type == COLLISION_EVENT.SEPERATE then
                body:seperateHandler()
            else
                body:collisionHandler()
            end
        end
    end
end

function FightingIn:_normalBodyCollision(body) --- 白球碰撞属性
    self:_removeCollisionBodys(body)
end
function FightingIn:_redBodyCollision(body)     --- 红色碰撞物
    self:_removeCollisionBodys(body)
end
function FightingIn:_yellowCollision(body)      --- 黄色碰撞物
    self:_removeCollisionBodys(body)
end
function FightingIn:_blueBodyCollision(body)    --- 蓝色碰撞物
    self:_removeCollisionBodys(body)
end

function FightingIn:_removeCollisionBodys(body)
    local n = body:getCollisionCounts()
    local color = body:getColor()
    if n>=2 then
        if color == BARRY_COLOR.RED then
            self:_updateTaskNums()
        end
        self:_removeBodys(body)
        body:clear()
    end
end


----------------------------------------------------------------------------------
function FightingIn:_shotSball()
    self.ballShotSpeed = math.abs(BALL_SHOT_SPEED * math.cos(self.tankAngle*math.pi/180))
    if self.ballShotSpeed < 0.02 then
        self.ballShotSpeed = 0.03
    end

    self.beganCollisionSign = true
    self.touchSign = false
    self.isShotBallSign = true
    self.steps = self.steps - 1
    global.gamingMgr:applyFn(LEVEL_EVENT.UPDATE_STEP_NUMS,self.steps)

    self:_setParParms()
--    self.drawNode:clear()
    
    self:_removeLineDot()
end
function FightingIn:_frameFunc()
    self:_updateGoldPot()
    self:_updateSballPos()
end
function FightingIn:_updateGoldPot()
    if self.isEnterBall then
        return
    end

    if self.hiddenGoldPot then
        return
    end

    local vx = self.goalUp:getPositionX()
    if vx <= define_left then
        self.goldPotSpeed = 5
    elseif vx >= define_right then
        self.goldPotSpeed = -5
    end
    vx = vx + self.goldPotSpeed
--    self.goalUp:setPositionX(vx)
--    self.goalDown:setPositionX(vx)
end

------------------------------------- 更新小球坐标 ----------------------------
function FightingIn:_updateSballPos()
    if not self.sball then
        return
    end
    if self.isShotBallSign then
        if self.ball_T > 1 then
            self.isShotBallSign = false
        end
        local ps = global.commonFunc:getTwoBezierPt(self.ballP0,self.ballP1,self.ballP2,self.ball_T)
        self.ball_T = self.ball_T + self.ballShotSpeed
        self.sball:setPosition(ps.x,ps.y)
    end
    
    local vy = self.sball:getPositionY()
    if vy < define_bottom-10 then
        self.sball:removeFromParent()
        self.sball = nil
        self:_gameResult()
    end
end

--------------------------- 结果 ---------------------------
function FightingIn:_gameResult()
    self:_calculateScores()
    self:_judgeWinOrLose()
end

function FightingIn:_judgeWinOrLose()     -- 计算成功，失败
    local n = self.m_task_nums
    local s = self.steps
--    print(n,s)
    if self.m_task_nums > 0 and self.steps > 0 then
        self:_restartAddShotBall()
        return
    end
    
    if self.framehandler then
        SCHE_MGR.unscheduleGlobal(self.framehandler)
        self.framehandler = nil
    end
    
    if self.m_task_nums > 0 and self.steps <= 0 then
        print("失败")
        global.popWndMgr:open(WND_NAME.FAILURE_WND,self.levelID)
    elseif self.m_task_nums <= 0 and self.steps >= 0 then
        print("过关")
        ---- 成功，保存数据
        local t = global.localMgr:getDataByKey(LOCAL_DATA_KEY.LEVEL_DATA)
        local levelData = t["level_"..self.levelID]
        local preScore = tonumber(levelData["score"])
        local score = self.top_ui:getScore()
        local star_1 = tonumber(self.m_data["star_1"])
        local star_2 = tonumber(self.m_data["star_2"])
        local star_3 = tonumber(self.m_data["star_3"])
        local star = 0
        if score > star_1 and score <= star_2 then
            star = 1
        elseif score > star_2 and score <= star_3 then
            star = 2
        elseif score > star_3 then
            star = 3
        end
        if score > preScore then
            levelData["score"] = score
        end
        levelData["star"] = star
        t["level_"..self.levelID] = levelData
        global.localMgr:setDataByKey(LOCAL_DATA_KEY.LEVEL_DATA,t)
        
        global.popWndMgr:open(WND_NAME.WIN_WND,self.levelID)
    end
end

function FightingIn:_calculateScores()    -- 计算得分
	for k, v in pairs(self.clearBallDict) do
        local sc = BARRY_SCORES["sc_"..v:getColor()]
        if v:getColor() == BARRY_COLOR.RED then
            self:_updateTaskNums()
        end
        self.tempScore = self.tempScore + sc
        v:getSp():removeFromParent()
    end
    
    global.gamingMgr:applyFn(LEVEL_EVENT.UPDATE_MY_SCORE,self.tempScore)
    self.clearBallDict = {}
    self.tempScore = 0
end
function FightingIn:_removeBodys(body)
    local score = BARRY_SCORES["sc_"..body:getColor()]
    self.tempScore = self.tempScore + score
    local id = body:getID()
    self.clearBallDict[id .. ""] = nil
end
--------- 轨迹的起始点 ----------------
function FightingIn:_getDotFirstPt()
    local vx,vy = self.sball:getPosition()
    local firstPt = cc.p(vx,vy)
    return firstPt
end
---------- 添加小球 ------------------------
function FightingIn:_restartAddShotBall()
    self.touchSign = true
    self.ball_T = 0
    self.sball = self:_getShotBall()
    self.isShotBallSign = false
    self:_setBallPos()
end

---------- 得到发射球 ---------
function FightingIn:_getShotBall()
    local sball = cc.Sprite:create(global.pathMgr:getPicUI("wonder_ball_1"))
    self:addChild(sball,7)
    sball:setPosition(define_centerx,define_top-BALL_G_RS)
    local body = barryFac.getBarry(BARRYS_TYPE.BALL_TYPE)
    body:bind(sball)
    self.isEnterBall = false
    self.beganCollisionSign = false
    return sball
end

function FightingIn:_setDotPos()
    local r = BALL_G_RS+25
    
    local vx = r*math.sin(self.tankAngle*math.pi/180)
    local vy = r - r * math.cos(self.tankAngle*math.pi/180)
    vx = -vx
    local sx = define_centerx + vx
    local sy = define_top-r+vy
    self.dotP0 = cc.p(sx,sy)
    
    local hx = math.tan(self.tankAngle*math.pi/180)*(self.dotP0.y+100)
    local vxx = self.dotP0.x-hx
    self.dotP2 = cc.p(vxx,-60)
    
    local rx,rh,ry
    if vxx > define_right then
        rx = define_right - self.dotP0.x
        rh = rx / math.tan(self.tankAngle*math.pi/180)
        rh = math.abs(rh)
        ry =  self.dotP0.y - rh
        self.dotP2 = cc.p(define_right,ry)
    elseif vxx < define_left then
        rx = self.dotP0.x - define_left
        rh = rx / math.tan(self.tankAngle*math.pi/180)
        rh = math.abs(rh)
        ry =  self.dotP0.y - rh
        self.dotP2 = cc.p(define_left,ry)
    end

    local vx = 150*math.sin(self.tankAngle*math.pi/180)
    vx = -vx
    local tempX = vx
    vx = self.dotP0.x + vx
--    self.ball_T = 0.02*3

    local hh = 150*math.cos(self.tankAngle*math.pi/180)
    if hh <0 then
        hh = -hh
    end
    self.dotP1 = cc.p(vx+tempX,self.dotP0.y-hh)
end

function FightingIn:_setBallPos()
    if self.sball then
        local vx = self.cr *math.sin(self.tankAngle*math.pi/180)
        local vy = self.cr - self.cr * math.cos(self.tankAngle*math.pi/180)
        vx = -vx
        local sx = define_centerx + vx
        local sy = define_top-self.cr +vy
        self.sball:setPosition(sx,sy)
        
        self.ballStartPt = cc.p(sx,sy)
    end
    self:_setParParms()
end

function FightingIn:_getTankAngle(pt)     -- 小球随发射罐儿移动
    local kx = pt.x - define_centerx
    local ky = pt.y - define_top
    local anxi = kx/ky
    local anle = math.atan(anxi) * 180 / math.pi
    return anle
end

---------------------------------------- 设置抛物线参数 ----------------------------------
function FightingIn:_setParParms()
    if nil == self.sball then
        return
    end
    self.ballP0 = self:_getDotFirstPt()
    local hx = math.tan(self.tankAngle*math.pi/180)*(self.ballP0.y+100)
    local vxx = self.ballP0.x-hx
    self.ballP2 = cc.p(vxx,-60)
    
    local rx,rh,ry
    if vxx > define_right then
    	rx = define_right - self.ballP0.x
    	rh = rx / math.tan(self.tankAngle*math.pi/180)
    	rh = math.abs(rh)
        ry =  self.ballP0.y - rh
        self.ballP2 = cc.p(define_right,ry)
    elseif vxx < define_left then
        rx = self.ballP0.x - define_left
        rh = rx / math.tan(self.tankAngle*math.pi/180)
        rh = math.abs(rh)
        ry =  self.ballP0.y - rh
        self.ballP2 = cc.p(define_left,ry)
    end
    
    local vx = 150*math.sin(self.tankAngle*math.pi/180)
    vx = -vx
    local tempX = vx
    vx = self.ballP0.x + vx
    self.ball_T = 0.02*3

    local hh = 150*math.cos(self.tankAngle*math.pi/180)
    if hh <0 then
        hh = -hh
    end
    self.ballP1 = cc.p(vx+tempX,self.ballP0.y-hh)
    
    self:_drawBallDot()
end
function FightingIn:_drawBallDot()
--    self:_setDotPos()
    
    self:_removeLineDot()
    local t = 0.045
    for i=16,1,-1 do
        local ps = global.commonFunc:getTwoBezierPt(self.ballP0,self.ballP1,self.ballP2,t)
--        local ps = global.commonFunc:getTwoBezierPt(self.dotP0,self.dotP1,self.dotP2,t)
        t = t+0.025
        
        local dot = self.dotDicts[i]
        dot:setPosition(ps)
        dot:setVisible(true)
    end
end

-------------------------- 疯狂奖励 ----------------------------
function FightingIn:_removeComboAwards()
    if self.combat_ui then
        self.combat_ui:removeFromParent()
        self.combat_ui = nil
    end

    self:_initGoldPot()
end

function FightingIn:_addCombAwards()
    self:_initComboScore()

    self.hiddenGoldPot = true
    if self.goalUp then
        self.goalUp:removeFromParent()
    end

    if self.goalDown then
        self.goalDown:removeFromParent()
    end
    self.goalUp = nil
    self.goalDown = nil
end

function FightingIn:_initComboScore()
    self.combat_ui = require("game/base/BaseCell").new("combat_ui")
    self.combat_ui:initCCB()
    self:addChild(self.combat_ui,2)
    
    for i=0,9 do 
        local sp = self.combat_ui["combat_body_"..i+1]
        local body,vers
        if i % 2 ==0 then
            vers = {cc.p(0,0),cc.p(0,36),cc.p(33,33),cc.p(36,0)}
        else
            vers = {cc.p(15,0),cc.p(15,33),cc.p(48,36),cc.p(48,0)}
        end
        body = barryFac.getBarry(BARRYS_TYPE.BARRY_COMBAT_BLOCK)
        body:setPhysicsShapeDatas(vers)
        body:bind(sp)
    end
end

function FightingIn:clear()
   if self.top_ui then
      self.top_ui:clear()
      self.top_ui:removeFromParent()
      self.top_ui = nil
   end
   if self.framehandler then
        SCHE_MGR.unscheduleGlobal(self.framehandler)
        self.framehandler = nil
   end
   
   if self.touchLayer then
        self.touchLayer:removeFromParent()
        self.touchLayer = nil
   end
   
    global.gamingMgr:unRegisterFn(LEVEL_EVENT.UPDATE_TASK_BARRY_NUMS)
    global.gamingMgr:unRegisterFn(LEVEL_EVENT.RESTART_GAME)
    global.gamingMgr:unRegisterFn(LEVEL_EVENT.CLICK_PROPS_EVENT)
    global.gamingMgr:unRegisterFn(LEVEL_EVENT.REMOVE_BODYS_EVENT)
   
end

function FightingIn:_clearBeforRes()
    self.m_task_nums = 0

    if self.top_ui then
        self.top_ui:clear()
        self.top_ui:removeFromParent()
        self.top_ui = nil
    end

    if self.level_ui then
        self.level_ui:removeFromParent()
        self.level_ui = nil
    end

    if self.tank then
        self.tank:removeFromParent()
        self.tank = nil
    end

--    self.tempBall = nil 
    if self.sball then
        self.sball:removeFromParent()
        self.sball = nil
    end

    if self.framehandler then
        SCHE_MGR.unscheduleGlobal(self.framehandler)
        self.framehandler = nil
    end
end

-------------------------- 测试代码 ---------------------------
function FightingIn:_testBlock()
--    self.block = cc.LayerColor:create(cc.c4b(0,0,0,255),200,50)
--    self:addChild(self.block,100)
--    self.block:setPosition(define_centerx,define_bottom-25)
    
    self.block = ccui.Scale9Sprite:create("scale_9.png")
    self.block:setContentSize(cc.size(200,50))
    self.block:setColor(cc.c3b(159, 168, 176))
    self:addChild(self.block,100)
    self.block:setPosition(define_centerx,define_bottom)
    local body = barryFac.getBarry(BARRYS_TYPE.BARRY_BLOCK_T)
    body:bind(self.block)
    local lisenter = node_touchEvent(self.block,handler(self,self._touchBlockBegan),handler(self,self._touchBlockMove),handler(self,self._touchBlockEnd),nil)
    lisenter:setSwallowTouches(false)
end

function FightingIn:_touchBlockBegan(touch,event)
    local pt = touch:getLocation()
--    trace(pt.x,pt.y)
    return true
end

function FightingIn:_touchBlockMove(touch,event)
    local pt = touch:getLocation()
    local p = self.block:getBoundingBox()
    if true or cc.rectContainsPoint(p,pt) then
        local pt2 = touch:getPreviousLocation()
        local vx = self.block:getPositionX()
        vx = vx+(pt.x-pt2.x)
        self.block:setPositionX(vx)        
    end
end

function FightingIn:_touchBlockEnd(touch,event)
    local pt = touch:getLocation()
--    trace(pt.x,pt.y)
end


return FightingIn