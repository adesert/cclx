
local MainCityManager = class("MainCityManager",require ("game/managers/BaseManager"))

function MainCityManager:ctor()
	self.super.ctor(self)
	
	self:_init()
end

function MainCityManager:_init()
    global.popWndMgr:register(KONG_WNDS.MAIN_CITY_WND,handler(self,self._openCityWnd),handler(self,self._closeCityWnd))
end

function MainCityManager:_openCityWnd()
    if not self.m_city_wnd then
        self.m_city_wnd =  require("game.modules.maincity.MainCityLayer").new()
        global.sceneMgr:getLayer(LAYER_TYPE.MAIN_UI_LAYER):addChild(self.m_city_wnd)
    end
end

function MainCityManager:_closeCityWnd()
    if self.m_city_wnd then
        self.m_city_wnd:clear()
        self.m_city_wnd:removeFromParent()
        self.m_city_wnd=nil
    end
end

return MainCityManager