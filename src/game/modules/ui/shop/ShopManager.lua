local ShopManager = class("ShopManager",require("game.managers.BaseManager"))

function ShopManager:ctor()
	self.super.ctor(self)
	
	self:_init()
end

function ShopManager:_init( )
    global.popWndMgr:register(SHOT_WNDS.GAME_SHOP_WND, handler(self,self._openShopWnd),handler(self, self._closeShopWnd))
end

function ShopManager:_openShopWnd()
    if not self.m_wnd then
        self.m_wnd = require("game/modules/ui/shop/ShopWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_wnd)
    end
end

function ShopManager:_closeShopWnd()
    if self.m_wnd then
        self.m_wnd:clear()
        self.m_wnd:removeFromParent()
        self.m_wnd = nil
    end
end

return ShopManager