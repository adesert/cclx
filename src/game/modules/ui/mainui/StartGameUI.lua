
local StartGameUI = class("StartGameUI",require("game.base.BaseLayer"))

function StartGameUI:ctor()
	self.super.ctor(self)
end

function StartGameUI:_overrideInit()
    self:showMaskBG()
    self:setPassEvent(true)
--    self:setMaskWH(define_w,define_h/2)
    
    local ccbname = "start_game_ui"
    self.ccb = self:loadCCB(ccbname)
    self.ccb:setCallFunc("enter_game_func",handler(self,self._enterGame))
    self.ccb:initCCB()
    self:addChild(self.ccb)
    self.ccb:setPosition(screen_w/2,screen_h/2-100)

    self.ccb:setScale(0.2)
    local s = cc.ScaleTo:create(0.5,1)
    local action1 = cc.EaseBackOut:create(s)
    self.ccb:runAction(action1)

    self:_init()
end

function StartGameUI:_init()
    local pos = {{652.0,277.0},{652.0,185.0}}
	for i=1,2 do
	   local item = require("game.modules.ui.mainui.item.SelectedItemCell").new(i)
	   item:setPosition(pos[i][1],pos[i][2])
	   self.ccb["start_ui"]:addChild(item)
	end
	
    pos = {{434.5,275.0},{435.5,164.0}}
	for i=1,2 do
	   local item = require("game.modules.ui.mainui.item.ItemBuyCell").new()
	   item:setPosition(pos[i][1],pos[i][2])
        self.ccb["start_ui"]:addChild(item)
	end
end

function StartGameUI:_enterGame()
    global.popWndMgr:close(SHOT_WNDS.GAME_MAIN_UI)
    global.popWndMgr:open(SHOT_WNDS.FIGHT_WND)
end

return StartGameUI