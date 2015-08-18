
local BlockPhysicsBody = class("BlockPhysicsBody",require("game.modules.gaming.barry.BasePhysicsBody"))

function BlockPhysicsBody:ctor()
    self.super.ctor(self)
end

function BlockPhysicsBody:_overrideInit()
    local QT_TYPE_RECT = cc.size(200,50)
    local QT_TYPE_RECT_MATERIAL = cc.PhysicsMaterial(1,1,1)

    local shape = cc.PhysicsShapeBox:create(QT_TYPE_RECT,QT_TYPE_RECT_MATERIAL)
    self:addShape(shape)

    self:setDynamic(false)      -- 静态
    self:setCategoryBitmask(1)
    self:setContactTestBitmask(1)
    self:setCollisionBitmask(1)
end

return BlockPhysicsBody