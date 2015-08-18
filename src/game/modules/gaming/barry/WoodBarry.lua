
--- 墙壁
local WoodBarry = class("WoodBarry",require("game.modules.gaming.barry.BasePhysicsBody"))

function WoodBarry:ctor(a,b,dir)
    self.a = a
    self.b = b
    self.dir = dir
	self.super.ctor(self)
end

function WoodBarry:_overrideInit()
    --- 墙壁物理属性
    local WALL_MATERIAL = cc.PhysicsMaterial(1,1,1)
    if self.dir == 2 then
        WALL_MATERIAL = cc.PhysicsMaterial(0.6,0.6,0.8)
    end
    local shape = cc.PhysicsShapeBox:create(cc.size(self.a,self.b),WALL_MATERIAL)
    self:addShape(shape)

    self:setDynamic(false)      -- 静态
    self:setCategoryBitmask(1)
    self:setContactTestBitmask(1)
    self:setCollisionBitmask(1)
    
    self:setBodyMass(3000)
end

----------------------- 碰撞处理 -------------------------
function WoodBarry:_overrideCollisionHandler()
end

return WoodBarry