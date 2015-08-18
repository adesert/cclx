
--[[
    下方疯狂奖励的碰撞物
]]--
local CombatBlockBody = class("CombatBlockBody",require("game.modules.gaming.barry.BasePhysicsBody"))

function CombatBlockBody:ctor()
    self.super.ctor(self)
end

function CombatBlockBody:_overrideInit()
    
end

function CombatBlockBody:setPhysicsShapeDatas(vers)
    local material = cc.PhysicsMaterial(1,1,1)
    local size = cc.size(100,30)
    local shape = cc.PhysicsShapePolygon:create(vers,material)
    self:addShape(shape)
    
    self:setDynamic(false)      -- 静态
    self:setCategoryBitmask(1)
    self:setContactTestBitmask(1)
    self:setCollisionBitmask(1) 
end

function CombatBlockBody:_overrideCollisionHandler()
    
end

return CombatBlockBody