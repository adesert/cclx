
------ 画一条碰撞的线段

local LineBody = class("LineBody",require("game.modules.gaming.barry.BasePhysicsBody"))

--[[
     type 1 是宝葫芦
     type 2 疯狂奖励
]]--
function LineBody:ctor(p0,p1,type)
    self.p0 = p0
    self.p1 = p1
    self.type = type
    self.super.ctor(self)
end

function LineBody:_overrideInit()
    local material = cc.PhysicsMaterial(0,0,0)
--    local shape = cc.PhysicsShapeEdgeSegment:create(self.p0,self.p1,material)
--    self:addShape(shape)
    
    local shape = cc.PhysicsShapeBox:create(cc.size(self.p0,self.p1),material)
    self:addShape(shape)

    self:setDynamic(false)      -- 静态
    self:setCategoryBitmask(1)
    self:setContactTestBitmask(1)
    self:setCollisionBitmask(1)
end

function LineBody:_overrideCollisionHandler()
    
end

return LineBody