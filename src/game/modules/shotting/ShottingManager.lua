
local ShottingManager = class("ShottingManager",require("game.managers.BaseManager"))

function ShottingManager:ctor()
    self.super.ctor(self)
    self:_init()    
end

function ShottingManager:_init()
    global.popWndMgr:register(SHOT_WNDS.FIGHT_UI,handler(self,self._openFightUI),handler(self,self._closeFightUI))
    global.popWndMgr:register(SHOT_WNDS.FIGHT_WND,handler(self,self._openFightWnd),handler(self,self._closeFightWnd))
    global.popWndMgr:register(SHOT_WNDS.ROCKER_WND,handler(self,self._openRocker),handler(self,self._closeRocker))
    global.popWndMgr:register(SHOT_WNDS.FIGHT_FAILURE_WND,handler(self,self._openFailWnd),handler(self,self._closeFailWnd))
    global.popWndMgr:register(SHOT_WNDS.FIGHT_WIN_WND,handler(self,self._openWinWnd),handler(self,self._closeWinWnd))
end

function ShottingManager:_openFailWnd()
    if not self.m_fail_wnd then
        self.m_fail_wnd = require("game.modules.shotting.FailureWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_fail_wnd)
    end
end

function ShottingManager:_closeFailWnd()
    if self.m_fail_wnd then
        self.m_fail_wnd:clear()
        self.m_fail_wnd:removeFromParent()
        self.m_fail_wnd = nil
    end
end

function ShottingManager:_openWinWnd()
    if not self.m_win_wnd then
        self.m_win_wnd = require("game.modules.shotting.WinWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_win_wnd)
    end
end
function ShottingManager:_closeWinWnd()
    if self.m_win_wnd then
        self.m_win_wnd:clear()
        self.m_win_wnd:removeFromParent()
        self.m_win_wnd = nil
    end
end

function ShottingManager:_openFightUI()
	if not self.m_fight_ui  then
	   self.m_fight_ui = require("game.modules.shotting.FightUI").new()
	   global.sceneMgr:getLayer(LAYER_TYPE.MAIN_UI_LAYER):addChild(self.m_fight_ui)
	end
end

function ShottingManager:_closeFightUI()
	if self.m_fight_ui then
	   self.m_fight_ui:clear()
	   self.m_fight_ui:removeFromParent()
	   self.m_fight_ui = nil
	end
end

function ShottingManager:_openFightWnd()
	if not self.m_fight_wnd  then
	    self.m_fight_wnd = require("game.modules.shotting.FightWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_fight_wnd)
	end
end
function ShottingManager:_closeFightWnd()
    if self.m_fight_wnd then
        self.m_fight_wnd:clear()
        self.m_fight_wnd:removeFromParent()
        self.m_fight_wnd = nil
    end
end

function ShottingManager:_openRocker()
	if not self.m_rocker then
	   self.m_rocker = require("game.modules.shotting.RockerControl").new()
--	   self.m_rocker:setPosition(100,100)
        global.sceneMgr:getLayer(LAYER_TYPE.TOUCH_LAYER):addChild(self.m_rocker)
	end
end

function ShottingManager:_closeRocker()
	if self.m_rocker then
	   self.m_rocker:clear()
	   self.m_rocker:removeFromParent()
	   self.m_rocker = nil
	end
end

return ShottingManager