local IAI = class("IAI")

function IAI:ctor()
	self.is_pause = false
end

function IAI:init(creature)
    self.m_creature = creature
end

function IAI:getOwner()
    return self.m_creature
end

function IAI:setType(type)
	self.ai_type = type
end

function IAI:getType()
	return self.ai_type
end

function IAI:handler()

end

function IAI:pause()
    self.is_pause = true
end

function IAI:resume()
    self.is_pause = false
end

function IAI:clear()
	
end

return IAI