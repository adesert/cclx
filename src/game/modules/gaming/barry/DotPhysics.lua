--[[
    小不点
]]--

local DotPhysics = class("DotPhysics",require("game.modules.gaming.barry.BasePhysicsBody"))

function DotPhysics:ctor(r)
    self.r = r
    self.super.ctor(self)	
end

function DotPhysics:_overrideInit()
    local shape = cc.PhysicsShapeCircle:create(self.r)
    self:addShape(shape)
    
    self:setDynamic(false)      -- 静态
    self:setCategoryBitmask(15)
    self:setContactTestBitmask(15)
    self:setCollisionBitmask(15)
end

function DotPhysics:setIndex(index)
    self.index = index
end

function DotPhysics:getIndex()
    return self.index
end

function DotPhysics:getR()
    return self.r
end

----------------------- 碰撞处理 -------------------------
function DotPhysics:_overrideCollisionHandler()
end

return DotPhysics