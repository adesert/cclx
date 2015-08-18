
local CameraManager = class("CameraManager")

function CameraManager:ctor()
	self:_init()
end

function CameraManager:_init()
    self.centerx = center_x
    self.centery = center_y
end

function CameraManager:setCamerWH(W,H)
	self.w = W
	self.h = H
end

function CameraManager:updateMove()
	local map = global.mapMgr:getCurrentMap()
	local vx,vy = map:getPosition()
	local mapW =  global.mapMgr:getCurrentMapWidth()
	local mapH = global.mapMgr:getCurrentMapHeight()
	
	local player = global.currentPlayer
    local dir = player:getDirection()
    
    local moveSpeed = player:getAttr(ATTR_DEFINE.SPEED)
    
    local px,py = player:getPosition()
    local xd = px + vx
    local gxdx = xd - center_x
    local GP = 10
    local SP = moveSpeed
    
--    global.dot:setPosition(cc.p(xd,py))
    
    if dir == DIRECTION.LEFT then
        if gxdx <= -GP then
            vx = vx + SP
            if vx<=0 then
                map:setPositionX(vx)
            end
        end
    elseif dir == DIRECTION.RIGHT then
        if gxdx >= GP then
            vx = vx - SP
            if vx + mapW >= define_right then
                map:setPositionX(vx)
            end
        end
    end
end

return CameraManager