
local ShopWnd= class("ShopWnd",require("game.base.BaseLayer"))

function ShopWnd:ctor()
	self.super.ctor(self)
end

function ShopWnd:_overrideInit()
    self:showMaskBG()
    self:setPassEvent(true)

    local ccbname = "shop_ui"
    self.ccb = self:loadCCB(ccbname)
    self.ccb:setCallFunc("closed_func",handler(self,self._closeShop))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    self:_init()
end

function ShopWnd:_init()
end

function ShopWnd:_closeShop()
    global.popWndMgr:close(SHOT_WNDS.GAME_SHOP_WND)
end

return ShopWnd