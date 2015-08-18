
local BasePhysicsBody = class("BasePhysicsBody",function ()
	return cc.PhysicsBody:create()
end)

function BasePhysicsBody:ctor()
	self:_overrideInit()
end

function BasePhysicsBody:_overrideInit()
end

function BasePhysicsBody:setKey(key)
    self.base_key = key
end
function BasePhysicsBody:getKey()
    return self.base_key
end

function BasePhysicsBody:setID(id)
    self._bid = id
end
function BasePhysicsBody:getID()
    return self._bid
end

function BasePhysicsBody:setType(type)
    self.type = type
end

function BasePhysicsBody:getType()
    return self.type
end

function BasePhysicsBody:setColor(c)
    self.cColor = c
end
function BasePhysicsBody:getColor()
    return self.cColor
end
function BasePhysicsBody:bind(sp)
    self.sp = sp
    self.sp:setPhysicsBody(self)
end
function BasePhysicsBody:getSp()
	return self.sp
end

function BasePhysicsBody:setBodyMass(mass)
    self:setMass(mass)
end

function BasePhysicsBody:_overrideCollisionHandler()
end

function BasePhysicsBody:collisionHandler()
    self:_overrideCollisionHandler()
end

function BasePhysicsBody:seperateHandler()
	self:_overrideSeperateHandler()
end

function BasePhysicsBody:_overrideSeperateHandler()
end

function BasePhysicsBody:clear()
    
end

function BasePhysicsBody:pause()
    self.m_isPause = true
    cc.Director:getInstance():getActionManager():pauseTarget(self.sp)
end

function BasePhysicsBody:resume()
    self.m_isPause = false
    cc.Director:getInstance():getActionManager():resumeTarget(self.sp)
end


return BasePhysicsBody