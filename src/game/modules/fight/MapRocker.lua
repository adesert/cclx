
local MapRocker = class("MapRocker",require("game.base.BaseLayer"))

function MapRocker:ctor()
    self.super.ctor(self)  
    self:_init()
    self:_registerFn()
end

function MapRocker:_init()
    self.bg = cc.Sprite:create("imgs/main_ui/rock_bg.png")
    self.bg:setPosition(100,100)
    self:addChild(self.bg)
    self.bg:setOpacity(0)

    self.rocker = cc.Sprite:create("imgs/main_ui/rocker_move.png")
    self.rocker:setPosition(100,100)
    self:addChild(self.rocker)

    self.rockerR = 150/2
    self.startPt = cc.p(100,100)
    self.rockerSign = 0
    self.movePt = nil
end

function MapRocker:_registerFn()
    self.touchLayer = cc.Layer:create()
    node_touchEvent(self.touchLayer,handler(self,self._onBeganTouch),handler(self,self._onMoveTouch),handler(self,self._endTouch),handler(self,self._layerRegisterTouch))
    self:addChild(self.touchLayer)

    self.framehandler = SCHE_MGR.scheduleUpdateGlobal(handler(self,self._frameFunc))
end

function MapRocker:_layerRegisterTouch(evt)
    if evt == "exit" then
        SCHE_MGR.unscheduleGlobal(self.framehandler)
    end
end
function MapRocker:_frameFunc()
    if self.rockerSign <= 0 then
        self.rocker:setPosition(self.startPt)
        return
    end

    self:_moveRocker()
end

function MapRocker:_onBeganTouch(touch,event)
    local location = touch:getLocation()
    if location.x>center_x then
        return false
    end
    self.movePt = touch:getLocation()
    self.rockerSign = 1
    self:_moveRocker()

    self.bg:runAction(cc.FadeIn:create(0.25))
    return true
end

function MapRocker:_onMoveTouch(touch,event)
    self.movePt = touch:getLocation()
    self.rockerSign = 1
end

function MapRocker:_endTouch(touch,event)
    self.rockerSign= 0
    self.movePt = nil
    
    global.fightMgr:applyFn(KONG_EVNET.UPDATE_MAP_MAP_END_DIR,0,self.move_dir,MACHINE_STATE_TYPE.STAND)
    self.bg:runAction(cc.FadeOut:create(0.25))
    
end

function MapRocker:_moveRocker()
    local location = self.movePt

    local cx = location.x - self.startPt.x
    local cy = location.y - self.startPt.y
    local k = cx*cx + cy*cy
    local m = self.rockerR * self.rockerR
    local tempR = 0
    if k>=m then
        tempR = self.rockerR
    else
        tempR = k^0.5
    end

    local cx = location.x-self.startPt.x
    local cy = location.y-self.startPt.y
    local angle = math.atan(cy/cx)
    local angles = angle*180/math.pi
    local vx,vy,dir
    vx = tempR * math.cos(angle)
    vy = tempR * math.sin(angle)
    if location.y >= self.startPt.y then
        vy = math.abs(vy)
        vx = math.abs(vx)
        if angle<0 then
            vx = -vx
        end
        vx = self.startPt.x + vx
        vy = self.startPt.y + vy
        self.rocker:setPosition(vx,vy)

        if angles>=0 and angles <45 then
            dir = 1
        elseif angles >-45 and angles <=0 then
            dir = 3
        else
            dir = 2
        end
    else
        vy = math.abs(vy)
        vx = math.abs(vx)
        if angle>0 then
            vx = -vx
            vy = -vy
        else
            vy = -vy
        end
        vx = self.startPt.x + vx
        vy = self.startPt.y + vy
        self.rocker:setPosition(vx,vy)

        if angles >=-45 and angles <=0 then
            dir = 1
        elseif angles >=0 and angle<=45 then
            dir = 3
        else
            dir = 4
        end
    end

    local vx = self.rocker:getPositionX()
    local c_dir = DIRECTION.RIGHT
    if vx<self.startPt.x then
        c_dir = DIRECTION.LEFT
    end

    self.move_dir = dir
    
    global.fightMgr:applyFn(KONG_EVNET.UPDATE_MAP_MOVE_DIR,c_dir,self.move_dir,MACHINE_STATE_TYPE.MOVE)
end

function MapRocker:clear()

end

return MapRocker