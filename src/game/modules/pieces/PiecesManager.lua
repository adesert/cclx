
local PiecesManager = class("PiecesManager",require("game/managers/BaseManager"))

function PiecesManager:ctor()
    self.super.ctor(self)
    self:_init()
end

function PiecesManager:_init()
    global.popWndMgr:register(WND_NAME.SOCRE_AWARDS,handler(self,self._openScoreAwards),handler(self,self._closeScoreAwards))
    global.popWndMgr:register(WND_NAME.LEVEL_ENTER_WNDS,handler(self,self._openLevelEnterWnd),handler(self,self._closeLevelEnterWnd))
    global.popWndMgr:register(WND_NAME.LOGIN_WNDS,handler(self,self._openLogin),handler(self,self._closeLogin))
    global.popWndMgr:register(WND_NAME.SHOP_WNDS,handler(self,self._openShop),handler(self,self._closeShop))
    global.popWndMgr:register(WND_NAME.TILI_BUYS,handler(self,self._openTili),handler(self,self._closeTili))
    global.popWndMgr:register(WND_NAME.FAILURE_WND,handler(self,self._openFailWnd),handler(self,self._closeFailWnd))
    global.popWndMgr:register(WND_NAME.WIN_WND,handler(self,self._openWinWnd),handler(self,self._closeWinWnd))
    
    global.popWndMgr:register(WND_NAME.test_ui,handler(self,self._openTest),handler(self,self._closeTest))
end

function PiecesManager:_openScoreAwards()
    if not self.m_score_award then
        self.m_score_award = require("game.modules.pieces.ScoreAwardsWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_score_award)
    end
end

function PiecesManager:_closeScoreAwards()
    if self.m_score_award then
        self.m_score_award:removeFromParent()
        self.m_score_award = nil
    end
end

------------------------------- 关卡进入--------------
function PiecesManager:_openLevelEnterWnd(lyid,lvid,lytype)
    if not self.enterLevel then
        self.enterLevel = require("game.modules.pieces.LevelStartWnd").new(lyid,lvid)
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.enterLevel)
    end
end

function PiecesManager:_closeLevelEnterWnd()
    if self.enterLevel then
        self.enterLevel:clear()
        self.enterLevel:removeFromParent()
        self.enterLevel = nil
    end
end
function PiecesManager:_openLogin()
    if not self.m_login then
        self.m_login = require("game.modules.pieces.LoginWnds").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_login)
    end
end

function PiecesManager:_closeLogin()
    if self.m_login then
        self.m_login:clear()
        self.m_login:removeFromParent()
        self.m_login = nil
    end
end

function PiecesManager:_openShop()
    if not self.m_shop then
    	self.m_shop = require("game.modules.pieces.ShopWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_shop)
    end
end

function PiecesManager:_closeLogin()
    if self.m_shop then
        self.m_shop:clear()
        self.m_shop:removeFromParent()
        self.m_shop = nil
    end
end
-----
function PiecesManager:_openTili()
    if self.m_tili then
        self.m_tili = require("game.modules.pieces.TiLiWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_tili)
    end
end

function PiecesManager:_closeTili()
    if self.m_tili then
        self.m_tili:clear()
        self.m_tili:removeFromParent()
        self.m_tili = nil
    end
end

---- 
function PiecesManager:_openFailWnd(levelid)
    if not self.m_failWnd then
        self.m_failWnd = require("game.modules.pieces.FailureWnd").new(levelid)
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_failWnd)
    end
end

function PiecesManager:_closeFailWnd()
    if self.m_failWnd then
        self.m_failWnd:clear()
        self.m_failWnd:removeFromParent()
        self.m_failWnd = nil
    end
end

----胜利界面
function PiecesManager:_openWinWnd(levelid,score)
    if not self.m_win_wnd then
        self.m_win_wnd = require("game.modules.pieces.SucceedWnd").new(levelid)
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_win_wnd)
    end
end

function PiecesManager:_closeWinWnd()
    if self.m_win_wnd then
        self.m_win_wnd:clear()
        self.m_win_wnd:removeFromParent()
        self.m_win_wnd = nil
    end
end

---------------------------------
function PiecesManager:_openTest()
    if not self.m_test then
        self.m_test = require("game/modules/gaming/testui").new()
        global.sceneMgr:getLayer(LAYER_TYPE.MSG_LAYER):addChild(self.m_test)
    end
end

function PiecesManager:_closeTest()
    if self.m_test then
        self.m_test:removeFromParent()
        self.m_test = nil
    end
end

return PiecesManager