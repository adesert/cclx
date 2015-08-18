
local SFManager = class("SFManager",require("game.managers.BaseManager"))

function SFManager:ctor()
	self.super.ctor(self)
	self:_init()
end

function SFManager:_init()
    global.popWndMgr:register( SF_WNDS.NORMAL_SF,handler(self, self._openNormal),handler(self,self._closeNormal))
    global.popWndMgr:register( SF_WNDS.SPECIAL_SF,handler(self, self._openSpecial),handler(self,self._closeSpecial))
end

function SFManager:_openNormal()
	if not self.m_normal then
	   self.m_normal = require("game.modules.sf.fs.SFNormalLayer").new()
       global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_normal)
	end
end

function SFManager:_closeNormal()
	if self.m_normal then
	   self.m_normal:clear()
	   self.m_normal:removeFromParent()
	   self.m_normal = nil
	end
end

function SFManager:_openSpecial()
    if not self.m_special then
        self.m_special = require("game.modules.sf.fs.SFSpecillayer").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_special)
    end
end

function SFManager:_closeSpecial()
    if self.m_normal then
        self.m_normal:clear()
        self.m_normal:removeFromParent()
        self.m_normal = nil
    end
end

return SFManager