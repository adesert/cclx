
local LevelWnd = class("LevelWnd",require("game.base.BaseLayer"))

function LevelWnd:ctor()
	self.super.ctor(self)
end

function LevelWnd:_overrideInit()
    self:setPassEvent(true)
    
    self.ccb = self:loadCCB("level_ui")
    self.ccb:setCallFunc("close_func",handler(self,self.close_func))
    self.ccb:setCallFunc("normal_func",handler(self,self.normal_func))
    self.ccb:setCallFunc("jingying_func",handler(self,self.jingying_func))
    self.ccb:setCallFunc("enter_fight",handler(self,self.enter_fight))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    self:_init()
    self:_initdata()
end

function LevelWnd:_init()
    self.ccb["tf_tili_1"]:setString("2020")
    self.ccb["tf_tili_2"]:setString("2020")

    self.ccb["tf_gold_value"]:setString("2015")
    self.ccb["tf_jinbi_value"]:setString("2015")

    self.ccb["img_level_name"]:setVisible(true)
    self.ccb["img_boss_name"]:setVisible(true)
    self.ccb["img_boss"]:setVisible(true)

    self.ccb["tf_my_zhanli_value"]:setString("2010")
    self.ccb["tf_tuijianzhanli"]:setString("231")

    self.ccb["tf_xiaohaotili"]:setString("5")
end

function LevelWnd:_initdata()
    local t = {{259.2,410.8},{480.8,410.8},{709.4,410.8},{261.8,192.8},{484.6,192.8},{709.4,192.8}}
    local data = {{id=1,img_name = "level_ui_13",img_content = "level_ui_20",star = 1},
        {id=2,img_name = "level_ui_14",img_content = "level_ui_21",star = 2},
        {id=3,img_name = "level_ui_15",img_content = "level_ui_22",star = 3},
        {id=4,img_name = "level_ui_16",img_content = "level_ui_23",star = 0},
        {id=5,img_name = "level_ui_17",img_content = "level_ui_24",star = 0},
        {id=6,img_name = "level_ui_18",img_content = "level_ui_25",star = 0}}

    for key, var in pairs(data) do
        local cell = require("game.modules.level.LevelCell").new()
        cell:setData(var)
        local vx = t[var.id][1]
        local vy = t[var.id][2]
        cell:setPosition(vx,vy)
        self.ccb:addChild(cell)
    end
end

function LevelWnd:close_func()
    global.popWndMgr:close(KONG_WNDS.LEVEL_WND)
end
function LevelWnd:normal_func()
end
function LevelWnd:jingying_func()
end

function LevelWnd:enter_fight()
    global.popWndMgr:close(KONG_WNDS.LEVEL_WND)
    global.popWndMgr:close(KONG_WNDS.MAIN_CITY_WND)
    global.popWndMgr:open(KONG_WNDS.FIGHT_LAYER)
end

function LevelWnd:clear()
    
end

return LevelWnd