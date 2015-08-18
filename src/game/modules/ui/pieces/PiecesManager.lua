local PiecesManager = class("PiecesManager",require("game.managers.BaseManager"))

function PiecesManager:ctor()
	self.super.ctor(self)
	
	self:_init()
end

function PiecesManager:_init( )
    global.popWndMgr:register(SHOT_WNDS.BEGAIN_GAME_WND, handler(self,self._startGame),handler(self, self._closeGame))
    global.popWndMgr:register(SHOT_WNDS.BEGAIN_GAME_FIGHT,handler(self,self._beginFight),handler(self,self._closeBegainFight))
    
    global.popWndMgr:register(SHOT_WNDS.GAME_FIGHT_WIN_WND,handler(self,self._openWinWnd),handler(self,self._closeWinWnd))
    global.popWndMgr:register(SHOT_WNDS.GAME_FIGHT_FAIL_WND,handler(self,self._openLoseWnd),handler(self,self._closeLoseWnd))
end

function PiecesManager:_startGame()
	if not self.m_start_ui then
	   self.m_start_ui = require("game.modules.ui.pieces.BeginGameWnd").new()
       global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_start_ui)
	end
end

function PiecesManager:_closeGame()
	if self.m_start_ui then
	   self.m_start_ui:clear()
	   self.m_start_ui:removeFromParent()
	   self.m_start_ui = nil
	end
end

function PiecesManager:_beginFight()
    if not self.m_fight_ui then
        self.m_fight_ui = require("game/modules/ui/pieces/BeginFightWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_fight_ui)
    end
end

function PiecesManager:_closeBegainFight()
    if self.m_fight_ui then
        self.m_fight_ui:clear()
        self.m_fight_ui:removeFromParent()
        self.m_fight_ui = nil
    end
end

function PiecesManager:_openWinWnd()
    if not self.m_win_wnd then
        self.m_win_wnd = require("game/modules/ui/pieces/WinGameWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_win_wnd)
    end
end
function PiecesManager:_closeWinWnd()
    if self.m_win_wnd then
        self.m_win_wnd:clear()
        self.m_win_wnd:removeFromParent()
        self.m_win_wnd = nil
    end
end

function PiecesManager:_openLoseWnd()
    if not self.m_lose_wnd then
        self.m_lose_wnd = require("game/modules/ui/pieces/LoseGameWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_lose_wnd)
    end
end
function PiecesManager:_closeLoseWnd()
    if self.m_lose_wnd then
        self.m_lose_wnd:clear()
        self.m_lose_wnd:removeFromParent()
        self.m_lose_wnd = nil
    end
end


return PiecesManager