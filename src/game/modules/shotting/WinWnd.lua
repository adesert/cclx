
local WinWnd = class("WinWnd",require("game.base.BaseLayer"))

function WinWnd:ctor()
	self.super.ctor(self)
end

function WinWnd:_overrideInit()
    self.ccb = self:loadCCB("win_ui")
    self.ccb:setCallFunc("back_func",handler(self,self._backFunc))
    self.ccb:setCallFunc("next_level_func",handler(self,self._nextLevelFunc))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    self:_init()
end

function WinWnd:_init()
    
end

function WinWnd:_backFunc()
	self:_closedUI()
end

function WinWnd:_nextLevelFunc()
    self:_closedUI()
end

function WinWnd:_closedUI()
    global.popWndMgr:close(SHOT_WNDS.FIGHT_WIN_WND)
    global.popWndMgr:close(SHOT_WNDS.FIGHT_WND)
--    global.popWndMgr:open(SHOT_WNDS.GAME_MAIN_UI)
    global.popWndMgr:open(MAININTERFACE)
end

return WinWnd