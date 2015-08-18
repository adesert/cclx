--
-- Author: dawn
-- Date: 2014-09-28 21:40:18
--
local LoadingManager = class("LoadingManager", require("game.managers.BaseManager"))

function LoadingManager:ctor( )
	self.super.ctor(self)

	self:_init()
end

function LoadingManager:_init( )
	global.popWndMgr:register(GAME_HTTP_LOADING,handler(self,self._openHttpMsg),handler(self, self._closeHttpMsg))
end

function LoadingManager:_openHttpMsg()
	if not self.m_http_layer then
		self.m_http_layer = require("game.modules.loading.HttpLoadingLayer").new()
        global.sceneMgr:getLayer(LAYER_TYPE.LOADING_LAYER):addChild(self.m_http_layer)
	end
end

function LoadingManager:_closeHttpMsg()
    if self.m_http_layer then
        self.m_http_layer:clear()
        self.m_http_layer:removeFromParent()
        self.m_http_layer = nil
	end
end

return LoadingManager