--[[
    JarTargetBarrier 
    目标
]]--

local JarTargetBarrier = class("JarTargetBarrier",require("game.modules.gaming.barry.BasePhysicsBody"))

function JarTargetBarrier:ctor()
    self.super.ctor(self)
end

function JarTargetBarrier:_overrideInit()
    local w = 150
    local h = 40
    ---------- 目标物理属性 ----------
    local JAR_TARGET_MATERIAL = cc.PhysicsMaterial(1,1,1)
    local shape = cc.PhysicsShapeBox:create(cc.size(w,h),JAR_TARGET_MATERIAL)
    self:addShape(shape)

    self:setDynamic(false)      -- 静态
    self:setCategoryBitmask(1)
    self:setContactTestBitmask(1)
    self:setCollisionBitmask(1)
end

----------------------- 碰撞处理 -------------------------
function JarTargetBarrier:_overrideCollisionHandler()
end

return JarTargetBarrier

