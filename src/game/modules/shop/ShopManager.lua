--
-- Author: dawn
-- Date: 2014-11-06 10:07:24
--
local ShopManager = class("ShopManager", require("game.managers.BaseManager"))

function ShopManager:ctor( )
	self.super.ctor(self)

	self:_init()
end

function ShopManager:_init( )
	global.popWndMgr:register(GAME_SHOP_WND,handler(self, self._openShop),handler(self, self._closeShop))
end

function ShopManager:_openShop( )
	if not self.m_shop then
		self.m_shop  = require("game.modules.shop.ShopWnd").new()
		global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_shop)
	end
end

function ShopManager:_closeShop( )
	self:_closeWnd(self.m_shop)
	self.m_shop = nil
end

function ShopManager:_closeWnd( wnd )
	if wnd then
		wnd:removeFromParent()
		wnd = nil
	end
end

return ShopManager