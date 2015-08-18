
local FailureWnd = class("FailureWnd",require("game.base.BaseLayer"))

function FailureWnd:ctor()
	self.super.ctor(self)
end

function FailureWnd:_overrideInit()
    self:showMaskBG()
    self:setPassEvent(true)
        
    self.ccb = self:loadCCB("failure_ui")
    self.ccb:setCallFunc("give_up_func",handler(self,self._giveUpFunc))
    self.ccb:setCallFunc("restart_func",handler(self,self._restartFunc))
    self.ccb:initCCB()
    self:addChild(self.ccb)
    
    self:_init()
end

function FailureWnd:_init()
--    self.ccb.tf_level_value:setString("9")
--    self.ccb.tf_score_value:setString("99")
end

function FailureWnd:_giveUpFunc()
	self:_closedUI()
end
function FailureWnd:_restartFunc()
    self:_closedUI()
end

function FailureWnd:_closedUI()
    global.popWndMgr:close(SHOT_WNDS.FIGHT_FAILURE_WND)
    global.popWndMgr:close(SHOT_WNDS.FIGHT_WND)
--    global.popWndMgr:open(SHOT_WNDS.GAME_MAIN_UI)
    global.popWndMgr:open(MAININTERFACE)
end

return FailureWnd