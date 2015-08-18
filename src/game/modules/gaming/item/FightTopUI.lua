
local FightTopUI = class("FightTopUI",require("game.base.BaseWindow"))

local props_pos = {{909,595},{995,595},{1081,595}}

function FightTopUI:ctor(lvid)
    self.m_id = lvid
    self.m_score = 0
    self.scoreR = 0
    self.m_data = global.dataMgr:getConfigDatas("level_config",self.m_id)
    self.m_steps = tonumber(self.m_data["balls"])
    local ccbname = "top_ui"
    self.super.ctor(self,ccbname)
    self:_init()
    self:_registerFn()
end

function FightTopUI:overrideInitCallFunc()
    self.m_callbacks["set_func"] = handler(self, self._setFunc)
end

function FightTopUI:_init()
    self.stepNums:setString(self.m_steps .. "")
    self.myScore:setString(self.m_score .. "")
    
--    local levelData = global.localMgr:getDataByKey(LOCAL_DATA_KEY.LEVEL_DATA)
    
    local propsData = global.localMgr:getDataByKey(LOCAL_DATA_KEY.PROPS)
    
    for key, var in pairs(props_pos) do
        local d = propsData["p_"..key]
        local n = tonumber(d.nums)
        if n > 0 then
            local cell = require("game.modules.gaming.item.PropsItems").new(key,n)
            self:addChild(cell)
            cell:setPosition(var[1],var[2])    
        end
    end
end

function FightTopUI:_registerFn()
    global.gamingMgr:registerFn(LEVEL_EVENT.UPDATE_MY_SCORE,handler(self,self._updateMyScore))
    global.gamingMgr:registerFn(LEVEL_EVENT.UPDATE_STEP_NUMS,handler(self,self._updateMySteps))
end

function FightTopUI:_updateMyScore(sc)
    self.scoreR = self.m_score + sc
    self.scoreFrame = SCHE_MGR.scheduleUpdateGlobal(handler(self,self._updateScore))
end

function FightTopUI:_updateScore()
    local r = self.scoreR
    self.m_score = self.m_score + 100
    if self.m_score >= r then
        self.m_score = r
        self.myScore:setString(self.m_score .. "")
        SCHE_MGR.unscheduleGlobal(self.scoreFrame)
        self.scoreFrame = nil
        return
    end
    self.myScore:setString(self.m_score .. "")
end

function FightTopUI:_updateMySteps(n)
    if self.m_steps < n then
        local action = cc.Blink:create(1, 5)
        self.head_img:runAction(action)
    end 
    self.m_steps = n
    self.stepNums:setString(self.m_steps .. "")
    
--    local action = cc.ScaleBy:create(0.15,0.6,0.6)
--    local actionBack = action:reverse()
--    local seq = cc.Sequence:create( action, actionBack)
end

function FightTopUI:getScore()
    return self.scoreR
end

function FightTopUI:_setFunc()
end

function FightTopUI:clear()
    global.gamingMgr:unRegisterFn(LEVEL_EVENT.UPDATE_MY_SCORE)
    global.gamingMgr:unRegisterFn(LEVEL_EVENT.UPDATE_STEP_NUMS)
    if self.scoreFrame then
        SCHE_MGR.unscheduleGlobal(self.scoreFrame)
    end
    self.scoreFrame = nil
end

return FightTopUI  