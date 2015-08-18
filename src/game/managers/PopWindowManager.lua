
-- Date: 2014-09-22 22:03:32
--
local PopWindowManager = class("PopWindowManager")

function PopWindowManager:ctor()
	self.m_wnd = {}
end

function PopWindowManager:register(name,openFn,closeFn)
	if not self.m_wnd[name] then
		self.m_wnd[name] = {}
		self.m_wnd[name].open = openFn
		self.m_wnd[name].close = closeFn
	end
end

function PopWindowManager:unregister(name)
	self.m_wnd[name] = nil
end

function PopWindowManager:open(name,...)
	local isThere = true
	if not self.m_wnd[name] then
		isThere = false
	end
	
	if isThere == true then
		self.m_wnd[name].open(...)
	end
end

function PopWindowManager:close(name)
	local isThere = true
	if not self.m_wnd[name] then
		isThere = false
	end
	if isThere == true then
		self.m_wnd[name].close()
	end
end

function PopWindowManager:closeAll()
	
end

return PopWindowManager