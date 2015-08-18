--
-- Author: dawn
-- Date: 2014-11-06 15:14:54
--
local SevenDayWnd = class("SevenDayWnd", require("game.base.BaseWindow"))

function SevenDayWnd:ctor( )
	local ccbname = "seven_day_ui"
	self.super.ctor(self.ccbname)

	self:_init()
end


function SevenDayWnd:overrideInitCallFunc()
	self.m_callbacks["back_func"] = handler(self, self._back_func)
	self.m_callbacks["day_func1"] = handler(self, self._day_func1)
	self.m_callbacks["day_func2"] = handler(self,self._day_func2)
	self.m_callbacks["day_func3"] = handler(self, self._day_func3)
	self.m_callbacks["day_func4"] = handler(self, self._day_func4)
	self.m_callbacks["day_func5"] = handler(self, self._day_func5)
	self.m_callbacks["day_func6"] = handler(self, self._day_func6)
end

function SevenDayWnd:_init()
	
end

function SevenDayWnd:_day_func1( )
	
end
function SevenDayWnd:_day_func2( )
	
end
function SevenDayWnd:_day_func3( )
	
end
function SevenDayWnd:_day_func4( )
	
end
function SevenDayWnd:_day_func5( )
	
end
function SevenDayWnd:_day_func6( )
	
end

function SevenDayWnd:_back_func( )
	global.popWndMgr:close(SEVEN_DAY_WND)
end

return SevenDayWnd