
local PiecesManager = class("PiecesManager",require("game.managers.BaseManager"))

function PiecesManager:ctor()
	self.super.ctor(self)
	
	self:_init()
end

function PiecesManager:_init()
    global.popWndMgr:registerFn(SF_WNDS.HELPER_WND,handler(self,self._openHelper),handler(self,self._closeHelper))
end

function PiecesManager:_openHelper()
	if not self.m_helper then
	   self.m_helper = require("game.modules.sf.pieces.HelperLayer").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_helper)
	end
end

function PiecesManager:_closeHelper()
    if self.m_helper then
        self.m_helper:clear()
        self.m_helper:removeFromParent()
        self.m_helper = nil
    end
end

return PiecesManager
