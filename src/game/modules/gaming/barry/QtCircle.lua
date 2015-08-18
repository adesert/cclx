--[[
    加速球
]]--

local QtCircle = class("QtCircle",require("game.modules.gaming.barry.BasePhysicsBody"))

function QtCircle:ctor()
    self.super.ctor(self)
end

function QtCircle:_overrideInit()
    local QT_TYPE_CIRCLE = 176/2
    local QT_TYPE_CIRCLE_MATERIAL = cc.PhysicsMaterial(1,1,1)
    
    local shape = cc.PhysicsShapeCircle:create(QT_TYPE_CIRCLE,QT_TYPE_CIRCLE_MATERIAL)
    self:addShape(shape)
    
    self:setDynamic(false)      -- 静态
    self:setCategoryBitmask(8)
    self:setContactTestBitmask(8)
    self:setCollisionBitmask(8) 
    
    self:setMass(15000)
end

----------------------- 碰撞处理 -------------------------
function QtCircle:_overrideCollisionHandler()
    local path = global.pathMgr:getBodyOtherRes("rebound_down_1")
    global.commonFunc:changePic(self:getSp(),path)
end

function QtCircle:_overrideSeperateHandler()
    local path = global.pathMgr:getBodyOtherRes("rebound_up_1")
    global.commonFunc:changePic(self:getSp(),path)
end

return QtCircle