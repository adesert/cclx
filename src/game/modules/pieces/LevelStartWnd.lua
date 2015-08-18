
--[[
    关卡开始
]]--
local LevelStartWnd = class("LevelStartWnd",require("game.base.BaseLayer"))

local props_pos = {{364.4,270.4},{456.2,270.4},{548.0,270.4}}

function LevelStartWnd:ctor(levelid)
    self.m_id = levelid
    self.m_data = global.localMgr:getDataByKey(LOCAL_DATA_KEY.LEVEL_DATA)
    self.super.ctor(self)
end

function LevelStartWnd:_overrideInit()
    self:showMaskBG()
    self:setPassEvent(true)

    local ccbname = "level_start"
    self.ccb = self:loadCCB(ccbname)
    self.ccb:setCallFunc("back_func",handler(self,self._backHome))
    self.ccb:setCallFunc("start_func",handler(self,self._playGame))
    self.ccb:initCCB()
    self:addChild(self.ccb)
    
    self.ccb:setScale(0.2)
    local s = cc.ScaleTo:create(0.5,1)
    local action1 = cc.EaseBackOut:create(s)
    self.ccb:runAction(action1)

    self:_init()
end

function LevelStartWnd:_init()
    local str = "第 " .. self.m_id .. " 关"
    
    local levelData = self.m_data["level_"..self.m_id]
    local score = levelData["score"]
    score = tonumber(score)
    local star = levelData["star"]
    star = tonumber(star)+1
    
    self.ccb.tf_title:setString(str)
    self.ccb.tf_my_score:setString(tostring(score))
    for i= star,3 do
    	local s = self.ccb["star_"..i]
    	s:removeFromParent()
    end
    
    local props = global.localMgr:getDataByKey(LOCAL_DATA_KEY.PROPS)
    
    for k, v in pairs(props_pos) do
    	local data = props["p_"..k]
    	local n = tonumber(data["nums"])
    	local id = tonumber(data["id"])
    	local cell = require("game/modules/gaming/item/PropsItems").new(id,n)
        cell:setPosition(v[1],v[2])
        self.ccb:addChild(cell)	
    end
end

function LevelStartWnd:_backHome()
    global.popWndMgr:close(WND_NAME.LEVEL_ENTER_WNDS)
end

function LevelStartWnd:_playGame()
    global.popWndMgr:close(WND_NAME.LEVEL_ENTER_WNDS)
    global.popWndMgr:open(WND_NAME.FIGHTING_IN,self.m_id)
    
    global.popWndMgr:close(GAME_START_UI)
    global.popWndMgr:close(GAME_LEVEL_MAP)
    global.popWndMgr:close(GAME_MAIN_UI)
end

function LevelStartWnd:clear()
    
end

return LevelStartWnd