
--[[
    发射的小球的物理属性
]]--

local BallBody = class("BallBody",require("game.modules.gaming.barry.BasePhysicsBody"))

function BallBody:ctor()
	self.super.ctor(self)
end

function BallBody:_overrideInit()
    --- 小球物理属性
    local BALL_R = 25/2
    local BALL_MATERIAL = cc.PhysicsMaterial(ball_x_1,ball_x_2,ball_x_3)
    local shape = cc.PhysicsShapeCircle:create(BALL_R,BALL_MATERIAL)
    self:addShape(shape)
    
    self:setDynamic(true)      -- 
--    self:setRotationEnable(false) -- 碰撞之后不旋转
    self:setCategoryBitmask(15)  --1111
    self:setContactTestBitmask(15)
    self:setCollisionBitmask(15)
    
    self:setMass(ball_x_4)
end

---- 模拟重力 ---------
function BallBody:setApplyForce(x,y)
    if self.givity == true then
    	return
    end
    x = x or 0
--    y = y or (-98-600) * self:getMass()
    y = -7990000
	self:applyForce(cc.p(x,y))
    self.givity = true
end

function BallBody:getGivitySign()
	return self.givity
end

-------- 设置速度 ----------
function BallBody:setVeSpeed(x,y)
    if self.speedsign == true then
    	return
    end
	self:setVelocity(cc.p(x,y))
	self.speedsign = true
end

----------------------- 碰撞处理 -------------------------
function BallBody:_overrideCollisionHandler()
end
return BallBody