
local CityMapManager = class("CityMapManager",require("game.managers.BaseManager"))

function CityMapManager:ctor()
	self.super.ctor(self)
	self:_init()
end

function CityMapManager:_init()
    global.popWndMgr:register(KONG_WNDS.CITY_MAP_WND,handler(self,self._openCityMap),handler(self,self._closeCityMap))
end

function CityMapManager:_openCityMap()
    if not self.m_city_map then
        self.m_city_map = require("game.modules.citymap.CityMapWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.MAIN_UI_LAYER):addChild(self.m_city_map)
    end
end

function CityMapManager:_closeCityMap()
    if self.m_city_map then
        self.m_city_map:clear()
        self.m_city_map:removeFromParent()
        self.m_city_map=nil
    end
end

return CityMapManager