
local RectBarrys = class("RectBarrys",require("game.modules.gaming.barry.BasePhysicsBody"))

function RectBarrys:ctor()
    self.super.ctor(self)
end

function RectBarrys:_overrideInit()
    local RECT_BOX = cc.size(45,34)
    local RECT_MATERIAL = cc.PhysicsMaterial(rect_x_1,rect_x_2,rect_x_3)
    
    local shape = cc.PhysicsShapeBox:create(RECT_BOX,RECT_MATERIAL)
    self:addShape(shape)

    self:setDynamic(false)      -- 静态
    self:setCategoryBitmask(2)
    self:setContactTestBitmask(2)
    self:setCollisionBitmask(2)

    self.colCount = 0 
    
    self:setMass(rect_x_4)
end

----------------------- 碰撞处理 -------------------------
function RectBarrys:_overrideCollisionHandler()
    self.colCount = self.colCount + 1
    
    if self.colCount >1 then
        return
    end
    
    local path = global.pathMgr:getRectRes("rect_"..BARRY_COLOR_NAME[self:getColor()] .. "_2")
    global.commonFunc:changePic(self:getSp(),path)
end

function RectBarrys:getCollisionCounts()
    return self.colCount
end
function RectBarrys:setCollisionCounts()
end

function RectBarrys:clear()
    self:getSp():removeFromParent()
end
return RectBarrys