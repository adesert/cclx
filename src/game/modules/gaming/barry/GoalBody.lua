

local GoalBody = class("GoalBody",require("game.modules.gaming.barry.BasePhysicsBody"))

function GoalBody:ctor(p0,p1)
    self.p0 = p0
    self.p1 = p1
    self.super.ctor(self)
end

function GoalBody:_overrideInit()
    local material = cc.PhysicsMaterial(1,1,1)
    
--    local shape = cc.PhysicsShapeEdgeSegment:create(self.p0,self.p1,material)
--    self:addShape(shape)
    local shape = cc.PhysicsShapeBox:create(cc.size(self.p0,self.p1),material)
    self:addShape(shape)
    
    self:setDynamic(false)      -- 静态
    self:setCategoryBitmask(1)
    self:setContactTestBitmask(1)
    self:setCollisionBitmask(1)
end

function GoalBody:_overrideCollisionHandler()
end

return GoalBody