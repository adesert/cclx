
--[[
    加速球
]]--
local QtRect = class("QtRect",require("game.modules.gaming.barry.BasePhysicsBody"))

function QtRect:ctor()
    self.super.ctor(self)
end

function QtRect:_overrideInit()
    local QT_TYPE_RECT = cc.size(64,58)
    local QT_TYPE_RECT_MATERIAL = cc.PhysicsMaterial(1,1,1)
    
    local shape = cc.PhysicsShapeBox:create(QT_TYPE_RECT,QT_TYPE_RECT_MATERIAL)
    self:addShape(shape)

    self:setDynamic(false)      -- 静态
    self:setCategoryBitmask(1)
    self:setContactTestBitmask(1)
    self:setCollisionBitmask(1)
    
    self:setMass(15000)
end

----------------------- 碰撞处理 -------------------------
function QtRect:_overrideCollisionHandler()
    local path = global.pathMgr:getBodyOtherRes("rebound_down_2")
    global.commonFunc:changePic(self:getSp(),path)
end

function QtRect:_overrideSeperateHandler()
    local path = global.pathMgr:getBodyOtherRes("rebound_up_2")
    global.commonFunc:changePic(self:getSp(),path)
end

return QtRect