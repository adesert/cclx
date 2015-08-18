
local Names = class("Names")

function Names:ctor()
	self:_init()
end

function Names:_init()
    local f = cc.FileUtils:getInstance():getStringFromFile("lan/shield_names.txt")
    f = string.split(f,"\13")
    self.ShieldNames = f
    
    f = cc.FileUtils:getInstance():getStringFromFile("lan/random_names.txt")
    f = string.split(f,"\13")
    self.randomNames = f
    
    local len = #self.ShieldNames
end

function Names:getRandomName()
    local len = #self.randomNames
    local rid =  math.random(1,len)
    return self.randomNames[rid]
end

function Names:getIsNameUsed(str)
    for key, var in pairs(self.ShieldNames) do
		if var == str then
		  return -1
		end
	end
	return 0
end

return Names