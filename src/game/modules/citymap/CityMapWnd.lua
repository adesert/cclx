
local CityMapWnd = class("CityMapWnd",require("game.base.BaseLayer"))

function CityMapWnd:ctor()
	self.super.ctor(self)
end

function CityMapWnd:_overrideInit()
    self:setPassEvent(true)
    
    self.ccb = self:loadCCB("city_map_ui")
    self.ccb:setCallFunc("city_func_1",handler(self,self.city_func_1))
    self.ccb:setCallFunc("city_func_2",handler(self,self.city_func_2))
    self.ccb:setCallFunc("city_func_3",handler(self,self.city_func_3))
    self.ccb:setCallFunc("city_func_4",handler(self,self.city_func_4))
    self.ccb:setCallFunc("city_close_func",handler(self,self._close_func))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    self:_init()
    self:_initdata()
end

function CityMapWnd:_init()
    
end

function CityMapWnd:_initdata()
	self.m_data = {{id = 1,state = 1},{id =2,state = 0},{id=3,state=0},{id=4,state=0},{id=5,state=0}}
    local tname = {self.ccb["city_name_1"],self.ccb["city_name_2"],self.ccb["city_name_3"],self.ccb["city_name_4"],self.ccb["city_name_5"]}
    local locks = {self.ccb["lock_1"],self.ccb["lock_2"],self.ccb["lock_3"],self.ccb["lock_4"],self.ccb["lock_5"]}
    for key, var in pairs(self.m_data) do
    	if var.state == 1 then
    		self.ccb["city_name_"..var.id]:setVisible(true)
            self.ccb["lock_"..var.id]:setVisible(false)
            self.ccb["btn_city_"..var.id]:setEnabled(true)
        else
            self.ccb["city_name_"..var.id]:setVisible(false)
            self.ccb["lock_"..var.id]:setVisible(true)
            self.ccb["btn_city_"..var.id]:setEnabled(false)
    	end
    end
end

function CityMapWnd:city_func_1()
    print("1")
end

function CityMapWnd:city_func_2()
    print("2")
end

function CityMapWnd:city_func_3()
    print("3")
end

function CityMapWnd:city_func_4()
    print("4")
end

function CityMapWnd:_close_func()
    global.popWndMgr:close(KONG_WNDS.CITY_MAP_WND)
end

function CityMapWnd:clear()
	
end

return CityMapWnd