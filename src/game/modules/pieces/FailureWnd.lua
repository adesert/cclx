
--[[

    挑战失败
]]--
local FailureWnd = class("FailureWnd",require("game.base.BaseLayer"))

function FailureWnd:ctor(lvid)
    self.m_id = lvid
    self.m_data = global.localMgr:getDataByKey(LOCAL_DATA_KEY.LEVEL_DATA)
    self.m_data = self.m_data["level_"..self.m_id]
    self.super.ctor(self)
end

function FailureWnd:_overrideInit()
    self:showMaskBG()
    self:setPassEvent(true)

    local ccbname = "lose_wnd"
    self.ccb = self:loadCCB(ccbname)
    self.ccb:setCallFunc("back_func",handler(self,self._backHome))
    self.ccb:setCallFunc("restarts_func",handler(self,self._restartGame))
    self.ccb:initCCB()
    self:addChild(self.ccb)
    
    self.ccb:setScale(0.2)
    local s = cc.ScaleTo:create(0.5,1)
    local action1 = cc.EaseBackOut:create(s)
    self.ccb:runAction(action1)

    self:_init()
end

function FailureWnd:_init()
    local str = "第 " .. self.m_id .. " 关"
    self.ccb["tf_title"]:setString(str)

    local score = self.m_data["score"]
    self.ccb["tf_my_score"]:setString(tostring(score))
end

function FailureWnd:_backHome()
    global.popWndMgr:close(WND_NAME.FAILURE_WND)
    global.popWndMgr:close(WND_NAME.FIGHTING_IN)
    
    global.popWndMgr:open(GAME_MAIN_UI)
    global.popWndMgr:open(GAME_LEVEL_MAP)
end
function FailureWnd:_restartGame()
    global.popWndMgr:close(WND_NAME.FAILURE_WND)
    global.gamingMgr:applyFn(LEVEL_EVENT.RESTART_GAME)
end

function FailureWnd:clear()
end

return FailureWnd