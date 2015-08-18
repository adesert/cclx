
local ActivityManager = class("ActivityManager",require("game/managers/BaseManager"))

function ActivityManager:ctor()
	self.super.ctor(self)
end

function ActivityManager:_init()
--    global.popWndMgr:register(SHOT_WNDS.FIGHT_UI,handler(self,self._openFightUI),handler(self,self._closeFightUI))
end

function ActivityManager:_openFightUI()
    if not self.m_wnd  then
        self.m_wnd = require("src/game/modules/activity/ActivityWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.MAIN_UI_LAYER):addChild(self.m_wnd)
    end
end

function ActivityManager:_closeFightUI()
    if self.m_wnd then
        self.m_wnd:clear()
        self.m_wnd:removeFromParent()
        self.m_wnd = nil
    end
end

return ActivityManager