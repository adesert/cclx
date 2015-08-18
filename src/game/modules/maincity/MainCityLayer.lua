
local MainCityLayer = class("MainCityLayer",require("game.base.BaseLayer"))

function MainCityLayer:ctor()
    self.m_data = nil
    self.m_id = 1   -- 临时使用id
	self.super.ctor(self)
end

function MainCityLayer:_overrideInit()
	self:_initMapLayers()
	self:_initRocker()
    self:_initUI()
end

function MainCityLayer:_initMapLayers()
	self.m_city = require("game.modules.maincity.city.CityMap").new(self.m_id)
	self:addChild(self.m_city,5)
end

function MainCityLayer:_initUI()
	self.m_ui = require("game.modules.maincity.CityUI").new()
	self:addChild(self.m_ui,15)
end

function MainCityLayer:_initRocker()
	self.m_rocker = require("game.modules.maincity.CityRocker").new()
	self:addChild(self.m_rocker,10)
end

function MainCityLayer:clear()
    if self.city then
    	self.city:clear()
    end
    
    if self.m_ui then
    	self.m_ui:clear()
    end
    
    if self.m_city then
        self.m_city:clear()
    end
end

return MainCityLayer