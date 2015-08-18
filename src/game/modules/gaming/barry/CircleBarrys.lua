

local CircleBarrys = class("CircleBarrys",require("game.modules.gaming.barry.BasePhysicsBody"))

function CircleBarrys:ctor()
    self.super.ctor(self)
end

function CircleBarrys:_overrideInit()
    local CIRCLE_R_L = 36/2
    local CIRCLE_MATERIAL = cc.PhysicsMaterial(circle_x_1,circle_x_2,circle_x_3)
    
    local shape = cc.PhysicsShapeCircle:create(CIRCLE_R_L,CIRCLE_MATERIAL)
    self:addShape(shape)
    
    self:setDynamic(false)      -- 静态
    self:setCategoryBitmask(1)
    self:setContactTestBitmask(1)
    self:setCollisionBitmask(1)

    self:setMass(circle_x_4)
    self.colCount = 0 
end

function CircleBarrys:_removeBalls()
    if self.colCount <= 0 then
        return
    end
    self:getSp():removeFromParent()  
end

----------------------- 碰撞处理 -------------------------
function CircleBarrys:_overrideCollisionHandler()
--    if self.colCount >5 then
--        if self:getColor() == BARRY_COLOR.RED then
--            global.gamingMgr:applyFn(LEVEL_EVENT.UPDATE_TASK_BARRY_NUMS)
--        end
--        global.gamingMgr:applyFn(LEVEL_EVENT.REMOVE_BODYS_EVENT,self)
--        self:_removeBalls()
--        return
--    end
    self.colCount = self.colCount + 1
    
    if self.colCount > 1 then
        return
    end
    local path = global.pathMgr:getCircleRes("circle_"..BARRY_COLOR_NAME[self:getColor()] .. "_2")
    global.commonFunc:changePic(self:getSp(),path)
end

function CircleBarrys:getCollisionCounts()
    return self.colCount
end
function CircleBarrys:setCollisionCounts()
end

function CircleBarrys:clear()
    self.colCount = 0
    self:getSp():removeFromParent()
end

return CircleBarrys