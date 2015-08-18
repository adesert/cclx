
local ShopUI = class("ShopUI",require("game.base.BaseLayer"))

function ShopUI:ctor()
	self.super.ctor(self)
end

function ShopUI:_overrideInit()
    local ccbname = "shop_ui"
    self.ccb = self:loadCCB(ccbname)
    self.ccb:setCallFunc("gold_func",handler(self,self._goldFunc))
    self.ccb:setCallFunc("diamon_func",handler(self,self._diamonFunc))  
    self.ccb:initCCB()
    self:addChild(self.ccb)

    --    self.ccb:setScale(0.2)
    --    local s = cc.ScaleTo:create(0.5,1)
    --    local action1 = cc.EaseBackOut:create(s)
    --    self.ccb:runAction(action1)

    self:_init()
end

function ShopUI:_init()
    self.shopCell = cc.Layer:create()
    self.ccb:addChild(self.shopCell)
    
    self:_goldFunc()
end

function ShopUI:_removeCells()
	self.shopCell:removeAllChildren()
end

function ShopUI:_goldFunc(target)
    print(target)
    self:_removeCells()
    
    self.ccb["btn_gold"]:setEnabled(false)
    self.ccb["btn_diamon"]:setEnabled(true)
    
    local pos = {{577.1,292.2},{577.1,209.1},{577.1,125.9}}
    local data = {{type = 1,value = 1000,money = 4,icon = "img_gold_1"},{type = 1,value = 2000,money = 6,icon = "img_gold_2"},{type = 1,value = 4000,money = 12,icon = "img_gold_3"}}
    for i=1,3 do
        local cell = require("game.modules.ui.mainui.item.ShopCell").new(data[i])
        cell:setPosition(pos[i][1],pos[i][2])
        self.shopCell:addChild(cell)
    end
end
--setEnabled
function ShopUI:_diamonFunc()
    self:_removeCells()
    
    self.ccb["btn_gold"]:setEnabled(true)
    self.ccb["btn_diamon"]:setEnabled(false)
    
    local pos = {{577.1,292.2},{577.1,209.1},{577.1,125.9}}
    local data = {{type = 2,value = 30,money = 4,icon = "img_diamon_1"},{type = 2,value = 50,money = 12,icon = "img_diamon_2"},{type = 2,value = 100,money = 30,icon = "img_diamon_3"}}
    for i=1,3 do
        local cell = require("game.modules.ui.mainui.item.ShopCell").new(data[i])
        cell:setPosition(pos[i][1],pos[i][2])
        self.shopCell:addChild(cell)
    end
end

return ShopUI