
local LoginManager = class("LoginManager",require("game/managers/BaseManager"))

function LoginManager:ctor()
    self.super.ctor(self)

    self:_init()
end

function LoginManager:_init()
    global.popWndMgr:register(KONG_WNDS.CREATE_ROLE_WND, handler(self,self._openCreateRoleWnd),handler(self, self._closeCreateRoleWnd))
    global.popWndMgr:register(KONG_WNDS.SELECTE_ROLE_WND, handler(self,self._openSelectRoleWnd),handler(self, self._closeSelectRoleWnd))
end

function LoginManager:_openCreateRoleWnd()
    if not self.m_create_role then
        self.m_create_role = require("game.modules.login.CreateRoleWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.LOGIN_LAYER):addChild(self.m_create_role)
    end    
end

function LoginManager:_closeCreateRoleWnd()
   if self. m_create_role then
        self.m_create_role:clear()
        self.m_create_role:removeFromParent()
        self.m_create_role = nil
   end
end

function LoginManager:_openSelectRoleWnd()
    if not self.m_select_role then
        self.m_select_role = require("game/modules/login/SelectRoleWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.LOGIN_LAYER):addChild(self.m_select_role)
    end    
end

function LoginManager:_closeSelectRoleWnd()
    if self. m_select_role then
        self.m_select_role:clear()
        self.m_select_role:removeFromParent()
        self.m_select_role = nil
    end
end

return LoginManager