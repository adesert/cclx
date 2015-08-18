
local MainUIManager = class("MainUIManager",require("game.managers.BaseManager"))

function MainUIManager:ctor()
	self.super.ctor(self)
	
	self:_init()
end

function MainUIManager:_init()
    global.popWndMgr:register(SHOT_WNDS.GAME_MAIN_UI, handler(self,self._openMainUI),handler(self, self._closeMainUI))
end

function MainUIManager:_openMainUI()
	if not self.m_main_ui then
	   self.m_main_ui = require("game.modules.ui.mainui.MainUI").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_main_ui)
	end
end

function MainUIManager:_closeMainUI()
	if self.m_main_ui then
	   self.m_main_ui:clear()
	   self.m_main_ui:removeFromParent()
	   self.m_main_ui = nil
	end
end

return MainUIManager