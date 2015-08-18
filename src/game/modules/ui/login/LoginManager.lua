
local LoginManager = class("LoginManager",require("game.managers.BaseManager"))

function LoginManager:ctor()
	self.super.ctor(self)
	
	self:_init()
end

function LoginManager:_init( )
    global.popWndMgr:register(SHOT_WNDS.GAME_LOGIN_WND, handler(self,self._openLoginWnd),handler(self, self._closeLoginWnd))
end

function LoginManager:_openLoginWnd()
    if not self.m_login_wnd then
        self.m_login_wnd = require("game/modules/ui/login/LoginWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_login_wnd)
    end
end

function LoginManager:_closeLoginWnd()
    if self.m_login_wnd then
        self.m_login_wnd:clear()
        self.m_login_wnd:removeFromParent()
        self.m_login_wnd = nil
    end
end

return LoginManager