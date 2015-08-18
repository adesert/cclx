--
-- Author: dawn
-- Date: 2014-09-28 19:30:47
--
local TestManager = class("TestManager", require("game.managers.BaseManager"))

function TestManager:ctor()
	self.super.ctor(self)
	self.m_wnd = nil

	self:_init()
end

function TestManager:_init( )
    global.popWndMgr:register(SHOT_WNDS.TEST_WND,handler(self, self._open),handler(self,self._close))
end

function TestManager:_open( )
	if not self.m_wnd then
		self.m_wnd = require("game.modules.test.TestUI").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_wnd)
	end
end

function TestManager:_close()
	if self.m_wnd then
		self.m_wnd:removeFromParent()
		self.m_wnd = nil
	end
end

return TestManager