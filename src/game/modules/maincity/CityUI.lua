
local CityUI = class("CityUI",require("game.base.BaseLayer"))

function CityUI:ctor()
	self.super.ctor(self)
end

function CityUI:_overrideInit()
    self.ccb = self:loadCCB("main_ui")
    self.ccb:setCallFunc("menu_func",handler(self,self._menu_func))
    self.ccb:setCallFunc("role_info_func",handler(self,self._roleInfoFunc))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    self:_init()
    self:_initdata()
end

function CityUI:_init()
    self.exp_cao = self.ccb["exp_cao"]
    self.tf_lv_s = self.ccb["tf_lv_s"]
    self.tf_zhanli = self.ccb["tf_zhanli"]
    self.img_role_name = self.ccb["img_role_name"]
--    self.img_role_head_icon = self.ccb["img_role_head_icon"]
end

function CityUI:_initdata()
	self.tf_lv_s:setString("1")
	self.tf_zhanli:setString("99999")
end

function CityUI:_menu_func()
    global.popWndMgr:open(KONG_WNDS.LEVEL_WND)
    global.popWndMgr:open(KONG_WNDS.CITY_MAP_WND)
end

function CityUI:_roleInfoFunc()
	global.popWndMgr:open(KONG_WNDS.ROLE_INFO_WND)
end

function CityUI:clear()
	
end

return CityUI