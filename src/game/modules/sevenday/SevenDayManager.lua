--
-- Author: dawn
-- Date: 2014-11-06 15:13:46
--
local SevenDayManager = class("SevenDayManager", require("game.base.BaseManager"))

function SevenDayManager:ctor( )
	self.super:ctor(self)

	self:_init()
end

function SevenDayManager:_init( )
	global.popWndMgr:register(SEVEN_DAY_WND, handler(self, self._openSevenDayWnd), handler(self, self._closeSevenDayWnd))
end

function SevenDayManager:_openSevenDayWnd( )
	if not self.m_seven_wnd then
		self.m_seven_wnd = require("game.modules.sevenday.SevenDayWnd").new()
		global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_seven_wnd)
	end
end

function SevenDayManager:_closeSevenDayWnd( )
	if self.m_seven_wnd then
		self.m_seven_wnd:removeFromParent()
		self.m_seven_wnd = nil
	end
end

return SevenDayManager