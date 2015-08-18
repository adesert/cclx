
-- 动作状态
local IState = class("IState")

function IState:ctor()
	
end

function IState:init(creature)
    self.m_creature = creature
    
    self:_overrideInit()
end

function IState:_overrideInit()
    
end

function IState:getOwner()
    return self.m_creature
end

return IState