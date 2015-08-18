
local SucceedWnd = class("SucceedWnd",require("game.base.BaseLayer"))

local START_POS = {{431.5,360.7},{511.7,375.3},{594.0,362.4}}

function SucceedWnd:ctor(level)
    self.m_id = level
    self.m_data = global.localMgr:getDataByKey(LOCAL_DATA_KEY.LEVEL_DATA)
    self.m_data = self.m_data["level_"..self.m_id]
    self.super.ctor(self)
end

function SucceedWnd:_overrideInit()
    self:showMaskBG()
    self:setPassEvent(true)

    local ccbname = "succeed_wnd"
    self.ccb = self:loadCCB(ccbname)
    self.ccb:setCallFunc("restart_func",handler(self,self._restartFunc))
    self.ccb:setCallFunc("next_func",handler(self,self._playNextGame))
    self.ccb:initCCB()
    self:addChild(self.ccb)
    
    self.ccb:setScale(0.2)
    local s = cc.ScaleTo:create(0.5,1)
    local action1 = cc.EaseBackOut:create(s)
    self.ccb:runAction(action1)
    
    self:_init()
end

function SucceedWnd:_init()
    local str = "第 " .. self.m_id .. " 关"
    self.ccb["tf_title"]:setString(str)

    local score = self.m_data["score"]
    self.ccb["tf_my_score"]:setString(tostring(score))
    
    self.my_score = tonumber(score)
    self.score_counts = 0
    
    self.ccb["my_score"]:setString(tostring(self.score_counts))
    self.scoreFrame = SCHE_MGR.scheduleUpdateGlobal(handler(self,self._updateScore))
    
    local starNames = {"star_1_3","star_2","star_1_3"}    
    local stars = self.m_data["star"]     
    stars = tonumber(stars)
    for i = 1,stars do
        local pos = START_POS[i]
        local path = global.pathMgr:getPicUI(starNames[i])
        local star_sp = cc.Sprite:create(path)
        star_sp:setPosition(pos[1],pos[2])
        self.ccb:addChild(star_sp)
        star_sp:setScale(2)
        
        local action1 = cc.ScaleTo:create(0.25,1)
        action1 = cc.EaseOut:create(action1,0.2)
        local action2 = cc.FadeIn:create(1)
        local action3 = cc.DelayTime:create(i/10)
        local seq = cc.Sequence:create(action3,action1,action2)
        star_sp:runAction(seq)
    end
end

function SucceedWnd:_updateScore()
    self.score_counts = self.score_counts + 100
    if self.score_counts >= self.my_score then
        self.score_counts = self.my_score
        self.ccb["my_score"]:setString(tostring(self.score_counts))
        SCHE_MGR.unscheduleGlobal(self.scoreFrame)
        self.scoreFrame = nil
        return
    end
    self.ccb["my_score"]:setString(tostring(self.score_counts))
end

function SucceedWnd:_restartFunc()
    global.popWndMgr:close(WND_NAME.WIN_WND)
    global.gamingMgr:applyFn(LEVEL_EVENT.RESTART_GAME)
end

function SucceedWnd:_playNextGame()
    global.popWndMgr:close(WND_NAME.WIN_WND)
    global.popWndMgr:close(WND_NAME.FIGHTING_IN)
    
    global.popWndMgr:open(GAME_MAIN_UI)
    global.popWndMgr:open(GAME_LEVEL_MAP)
end

function SucceedWnd:clear()
    if self.scoreFrame then
        SCHE_MGR.unscheduleGlobal(self.scoreFrame)
        self.scoreFrame = nil
    end
end

return SucceedWnd