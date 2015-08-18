
local WeaponUI = class("WeaponUI",require("game.base.BaseLayer"))

function WeaponUI:ctor()
	self.super.ctor(self)
end

function WeaponUI:_overrideInit()
    local ccbname = "weapon_ui"
    self.ccb = self:loadCCB(ccbname)
    self.ccb:setCallFunc("xiexia_func",handler(self,self._xiexiaFunc))
    self.ccb:setCallFunc("zhuangbei_func",handler(self,self.zhuangBeiFunc))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    --    self.ccb:setScale(0.2)
    --    local s = cc.ScaleTo:create(0.5,1)
    --    local action1 = cc.EaseBackOut:create(s)
    --    self.ccb:runAction(action1)

    self:_init()
end

function WeaponUI:_init()
    local pos = {{98.6,96.3},{280.6,96.3},{462.6,96.3},{644.6,96.3}}
    for i=1,4 do
        local cell = require("game.modules.ui.mainui.item.WeaponCell").new()
        cell:setPosition(pos[i][1],pos[i][2])
        self.ccb:addChild(cell)
        
        if i>1 then
            cell:setHidden(false)
        end
    end
    
    pos = {{863.2,98.1},{1039.2,98.1}}
    for i=1,2 do
        local cell = require("game.modules.ui.mainui.item.WeaponCell").new()
        cell:setPosition(pos[i][1],pos[i][2])
        self.ccb:addChild(cell)
        cell:setZhuangBeiState(false)
    end
    
    self.ccb["tf_weapon_name"]:setString("M4A1")
    self.ccb["tf_lv"]:setString("10")
    self.ccb["tf_gongji"]:setString("9999")
    self.ccb["tf_zhuangdan"]:setString("9999")
    self.ccb["tf_baoji"]:setString("9999")
    self.ccb["tf_shesu"]:setString("19999")
end

function WeaponUI:_xiexiaFunc()
	
end

function WeaponUI:zhuangBeiFunc()
    
end

function WeaponUI:clear()
	
end

return WeaponUI