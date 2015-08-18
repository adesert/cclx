
--[[
    梯形碰撞物
]]--
local TarBarrys = class("TarBarrys",require("game.modules.gaming.barry.BasePhysicsBody"))

function TarBarrys:ctor()
    self.super.ctor(self)
end

function TarBarrys:_overrideInit()
end

--------------------------------------------------------------------
--- 最多 4个点
function TarBarrys:setTarPoint(vers)
    local TAR_BOX = cc.size(66,38)
    local TAR_MATERIAL = cc.PhysicsMaterial(tar_x_1,tar_x_2,tar_x_3)
    
    local shape = cc.PhysicsShapePolygon:create(vers,TAR_MATERIAL)
    self:addShape(shape)

    self:setDynamic(false)      -- 静态
    self:setCategoryBitmask(4)
    self:setContactTestBitmask(4)
    self:setCollisionBitmask(4)

    self.colCount = 0
    
    self:setMass(tar_x_4)
end

----------------------- 碰撞处理 -------------------------
function TarBarrys:_overrideCollisionHandler()
    self.colCount = self.colCount + 1
    
    if self.colCount > 1 then
        return
    end
    
    local path = global.pathMgr:getladderRes("ladder_"..BARRY_COLOR_NAME[self:getColor()] .. "_2")
    global.commonFunc:changePic(self:getSp(),path)
end

function TarBarrys:getCollisionCounts()
    return self.colCount
end
function TarBarrys:setCollisionCounts()
end

function TarBarrys:clear()
    self:getSp():removeFromParent()
end

return TarBarrys
