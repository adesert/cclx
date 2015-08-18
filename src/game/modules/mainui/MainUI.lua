--
-- Author: dawn
-- Date: 2014-10-30 11:50:27
--
local MainUI = class("MainUI", require("game.base.BaseWindow"))

function MainUI:ctor( )
	local ccbname  = "main_ui"
	self.super.ctor(self,ccbname)

	self:_init()
end

function MainUI:overrideInitCallFunc()
	self.m_callbacks["add_suger_func"] = handler(self, self._addSugerFunc)
	self.m_callbacks["add_diamon_func"] = handler(self, self._addDiamonFunc)
	self.m_callbacks["shop_func"] = handler(self, self._openShopWnd)
	self.m_callbacks["mail_func"] = handler(self, self._openMailWnd)
	self.m_callbacks["option_func"] = handler(self, self._openSetWnd)
	self.m_callbacks["back_func"] = handler(self, self._openBackUI)
end

function MainUI:_init()
	self.tf_suger_value:setString("+1000000")
	self.tf_dimon_value:setString("1000")
end

function MainUI:_addSugerFunc( )
	
end

function MainUI:_addDiamonFunc( )
	
end

function MainUI:_openShopWnd( )
	global.popWndMgr:open(GAME_SHOP_WND)
end

function MainUI:_openMailWnd( )
	
end

function MainUI:_openSetWnd( )
	-- global.popWndMgr:open(GAME_START_UI)
end

function MainUI:_openBackUI( )
	global.popWndMgr:close(GAME_MAIN_UI)
	global.popWndMgr:close(GAME_LEVEL_MAP)
	global.popWndMgr:open(GAME_LOGIN_WND)
end

return MainUI