
local LevelManager = class("LevelManager",require("game.managers.BaseManager"))

function LevelManager:ctor()
	self.super.ctor(self)
	
	self:_init()
end

function LevelManager:_init()
    global.popWndMgr:register(KONG_WNDS.LEVEL_WND,handler(self,self._openLevelWnd),handler(self,self._closeLevelWnd))
end

function LevelManager:_openLevelWnd()
    if not self.m_level_wnd then
        self.m_level_wnd = require("game.modules.level.LevelWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.MAIN_UI_LAYER):addChild(self.m_level_wnd)
    end
end

function LevelManager:_closeLevelWnd()
    if self.m_level_wnd then
        self.m_level_wnd:clear()
        self.m_level_wnd:removeFromParent()
        self.m_level_wnd=nil
    end
end

return LevelManager