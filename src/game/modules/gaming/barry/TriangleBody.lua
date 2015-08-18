
--[[
    三角形body
]]--

local TriangleBody = class("TriangleBody",require("game.modules.gaming.barry.BasePhysicsBody"))

function TriangleBody:ctor()
    self.super.ctor(self)
end

function TriangleBody:_overrideInit()
end

--- 最多 4个点
function TriangleBody:setTrianglePoint(vers)
--    local vers = {p0,p1,p2}
    --- 三角形物理属性
    local TRIANGLE_MATERIAL = cc.PhysicsMaterial(tars_x_1,tars_x_2,tars_x_3)
    local shape = cc.PhysicsShapePolygon:create(vers,TRIANGLE_MATERIAL)
    self:addShape(shape)
    
    self:setDynamic(false)      -- 静态
    self:setCategoryBitmask(1)
    self:setContactTestBitmask(1)
    self:setCollisionBitmask(1)
    
    self.colCount = 0
    
    self:setMass(tars_x_4)
end

----------------------- 碰撞处理 -------------------------
function TriangleBody:_overrideCollisionHandler()
    self.colCount = self.colCount + 1
    if self.colCount > 1 then
        return
    end
    
    local path = global.pathMgr:getTriangleRes("triangle_"..BARRY_COLOR_NAME[self:getColor()] .. "_2")
    global.commonFunc:changePic(self:getSp(),path)
end

function TriangleBody:getCollisionCounts()
    return self.colCount
end
function TriangleBody:setCollisionCounts()
end

function TriangleBody:clear()
    self:getSp():removeFromParent()
end
return TriangleBody