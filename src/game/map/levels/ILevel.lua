
local ILevel  = class("ILevel")

function ILevel:ctor(id)
    self.m_id = id
    self:_init()
end

function ILevel:_init()
	self:_overrideInit()
end

function ILevel:_overrideInit()
    
end

function ILevel:parseMapData(map)
	self.m_map_data = map
	self:_overrideParseMapGroup()
end

function ILevel:getMapData()
    return self.m_map_data
end

function ILevel:_overrideParseMapGroup()
    
end

function ILevel:handler()
	
end

function ILevel:clear()
	
end

return ILevel