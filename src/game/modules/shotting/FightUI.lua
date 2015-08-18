
local FightUI = class("FightUI",require("game.base.BaseLayer"))

function FightUI:ctor()
	self.super.ctor(self)
end

function FightUI:_overrideInit()
    self.cell = require("game.base.BaseCell").new("fight_ui")
--    self.cell:setCallFunc("stop_game_func",handler(self, self._stopGameFunc))
    self.cell:setCallFunc("weapon_func1",handler(self,self._weaponFunc1))
    self.cell:setCallFunc("weapon_func2",handler(self,self._weaponFunc2))
    self.cell:setCallFunc("jijia_func",handler(self,self._jijiaFunc))
    self.cell:setCallFunc("shot_func",handler(self, self._shotFunc))
    self.cell:initCCB()
    
    self:addChild(self.cell)
    
    global.shotMgr:registerFn(GAME_EVENTS.UPDATE_ROLE_HD_VALUE,handler(self,self._updateRoleHD))
    global.shopMgr:registerFn(GAME_EVENTS.UPDATE_LEVEL_LEFT_TIME,handler(self,self._updateTime))
        
    self:_init()
end

function FightUI:_init()
--    self.cell["sp_role_hd_value"]:setScaleX(1)
--    self.cell["tf_time_cd"]:setString("")
end

function FightUI:_updateRoleHD(hd)
--    self.cell["sp_role_hd_value"]:setScaleX(hd/100)
--    if hd<=0 then
--        global.popWndMgr:open(SHOT_WNDS.FIGHT_FAILURE_WND)
--    end
    --
end

function FightUI:_updateTime(t)
    t = tonumber(t)
    local s = global.timeUtil:getShortTimeString(t)
--    print("s---->>>",s)
    
--    if self.cell then
--        self.cell["tf_time_cd"]:setString(s.."")
--    end
--    if t<=0 then
--        global.popWndMgr:close(SHOT_WNDS.FIGHT_WND)
--        global.popWndMgr:open(SHOT_WNDS.FIGHT_WIN_WND)
--        return
--    end
end

function FightUI:_stopGameFunc()
--    global.popWndMgr:close(SHOT_WNDS.FIGHT_WND)
--    global.popWndMgr:open(SHOT_WNDS.GAME_MAIN_UI)
--    global.popWndMgr:open(SHOT_WNDS.FIGHT_WIN_WND)
end

function FightUI:_shotFunc()
--    global.shotMgr:applyFn(GAME_EVENTS.WEAPON_SHOT_SKILLS,5)
    cc.Director:getInstance():setAnimationInterval(1.0 / 5)
end
function FightUI:_weaponFunc1()
    global.shotMgr:applyFn(GAME_EVENTS.WEAPON_SHOT_SKILLS,2)
end
function FightUI:_weaponFunc2()
    global.shotMgr:applyFn(GAME_EVENTS.WEAPON_SHOT_SKILLS,3)
end
function FightUI:_jijiaFunc()
    global.shotMgr:applyFn(GAME_EVENTS.WEAPON_SHOT_SKILLS,4)
end

function FightUI:clear()
    global.shotMgr:unRegisterFn(GAME_EVENTS.UPDATE_LEVEL_LEFT_TIME)
    global.shotMgr:unRegisterFn(GAME_EVENTS.UPDATE_ROLE_HD_VALUE)
end

return FightUI