
local CityMap = class("CityMap",require("game.base.BaseLayer"))

function CityMap:ctor(id)
    self.m_id = id
	self.super.ctor(self)
end

function CityMap:_overrideInit()
    self.m_city = require("game.modules.maincity.city.CityFac").getCityByid(self.m_id)
    self:addChild(self.m_city)
    
    global.mainCityMgr:registerFn(KONG_EVNET.UPDATE_CITY_MAP_MOVE_DIR,handler(self,self._updateDir))
    global.mainCityMgr:registerFn(KONG_EVNET.UPDATE_CITY_MAP_END_DIR,handler(self,self._updateDirEnd))
end

function CityMap:_updateDir(dir,moveDir,actionName)
    self.m_city:updateDir(dir,moveDir,actionName)
end

function CityMap:_updateDirEnd(dir,moveDir,actionName)
    self.m_city:updateDirEnd(dir,moveDir,actionName)
end

function CityMap:clear()
    self.m_city:clear()
    global.mainCityMgr:unRegisterFn(KONG_EVNET.UPDATE_CITY_MAP_MOVE_DIR)
    global.mainCityMgr:unRegisterFn(KONG_EVNET.UPDATE_CITY_MAP_END_DIR)
end

return CityMap