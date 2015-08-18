
local RoleInfoManager = class("RoleInfoManager",require("game.managers.BaseManager"))

function RoleInfoManager:ctor()
	self.super.ctor(self)
	
	self:_init()
end

function RoleInfoManager:_init()
    global.popWndMgr:register(KONG_WNDS.ROLE_INFO_WND,handler(self,self._openRoleInfoWnd),handler(self,self._closeRoleInfoWnd))
    global.popWndMgr:register(KONG_WNDS.ROLE_INFO_TIPS_WND,handler(self,self._openRoleTipsWnd),handler(self,self._closeRoleTipsWnd))
end

function RoleInfoManager:_openRoleInfoWnd()
    if not self.m_role_info then
        self.m_role_info = require("game.modules.role.RoleInfoWnd").new()
        
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_role_info)
    end
end

function RoleInfoManager:_closeRoleInfoWnd()
    if self.m_role_info then
        self.m_role_info:clear()
        self.m_role_info:removeFromParent()
        self.m_role_info = nil
    end
end

function RoleInfoManager:_openRoleTipsWnd(data)
    if not self.m_role_tips then
        self.m_role_tips = require("game/modules/role/EquTipsWnd").new(data)
--        self.m_role_tips:setData(data)
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_role_tips)
    end
end

function RoleInfoManager:_closeRoleTipsWnd()
    if self.m_role_tips then
        self.m_role_tips:clear()
        self.m_role_tips:removeFromParent()
        self.m_role_tips = nil
    end
end

return RoleInfoManager