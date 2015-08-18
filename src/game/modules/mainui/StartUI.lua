--
-- Author: dawn
-- Date: 2014-10-31 16:43:21
-- 开始进行消除的界面

local StartUI = class("StartUI", require("game.base.BaseWindow"))

function StartUI:ctor( )
	local ccbname  = "start_ui"
	self.super.ctor(self,ccbname)
	
    local function onBegan(touch,event)
        return true
    end
    node_touchEvent(self,onBegan,nil,nil,nil)

	self:_init()
end

function StartUI:overrideInitCallFunc()
	self.m_callbacks["back_func"] = handler(self, self._backFunc)
	self.m_callbacks["start_game_func"] = handler(self, self._startFunc)
end

function StartUI:_init()
	local ly = cc.LayerColor:create(cc.c4b(0,0,0,128))
	ly:setContentSize(cc.size(screen_w,screen_h))
	self.ui_bg:addChild(ly)

	self.tf_lv_value:setString("1")
end

function StartUI:_backFunc()
	global.popWndMgr:close(GAME_START_UI)
end

function StartUI:_startFunc()
	global.popWndMgr:open(GAING_ON_UI)
	global.popWndMgr:close(GAME_START_UI)
	global.popWndMgr:close(GAME_LEVEL_MAP)
	global.popWndMgr:close(GAME_MAIN_UI)
end

function StartUI:clear()
	
end

return StartUI