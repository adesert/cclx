--
-- Date: 2014-08-20 18:49:06
--
local BaseManager = class("BaseManager")

function BaseManager:ctor()
	self.dict = {}
end

function BaseManager:registerFn(name,fn)
--	self.dict[tostring(name)] = fn
	local t = self.dict[tostring(name)]
	t = t or {}
--    table.insert(t,fn)
    local n = table.nums(t) + 1
    t[n .. ""] = fn
    self.dict[tostring(name)] = t
    return n
end

function BaseManager:applyFn(name,...)
--	local fn = self.dict[tostring(name)]
--	if fn ~=nil and tolua.isnull(fn) ~= nil then
--		fn(...)
--	end
    local t = self.dict[tostring(name)]
    if t then
        for key, var in pairs(t) do
        	if var ~= nil then
        	   var(...)
        	end
        end
    end
end

function BaseManager:unRegisterFn(name,key)
    if nil == key then
        self.dict[tostring(name)] = nil
    else
        local t = self.dict[tostring(name)]
        t[key .. ""] = nil
        self.dict[tostring(name)] = t
    end
end

function BaseManager:clearAll()
	self.dict = {}
end

return BaseManager