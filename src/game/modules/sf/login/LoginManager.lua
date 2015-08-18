
local LoginManager = class("LoginManager",require("game/managers/BaseManager"))

function LoginManager:ctor()
    self.super.ctor(self)

    self:_init()
end

function LoginManager:_init()
    global.popWndMgr:register(SF_WNDS.LOGIN_WNDS, handler(self,self._openLoginWnd),handler(self, self._closeLoginWnd))
end

function LoginManager:_openLoginWnd()
    if not self.m_login then
        self.m_login = require("game.modules.sf.login.LoginLayer").new()
        global.sceneMgr:getLayer(LAYER_TYPE.LOGIN_LAYER):addChild(self.m_login)
    end    
end

function LoginManager:_closeLoginWnd()
    if self. m_login then
        self.m_login:clear()
        self.m_login:removeFromParent()
        self.m_login = nil
    end
end

return LoginManager