
local FightWnd = class("FightWnd",require("game.base.BaseLayer"))

function FightWnd:ctor()
	self.super.ctor(self)
end

function FightWnd:_overrideInit()
    global.popWndMgr:open(SHOT_WNDS.FIGHT_UI)
    global.popWndMgr:open(SHOT_WNDS.ROCKER_WND)
    global.mapMgr:joinMap("1_1")
    
    global.shotMgr:registerFn(GAME_EVENTS.CHANGE_SHOT_MAN_DIR,handler(self,self._changeManDirMove))
    global.shotMgr:registerFn(GAME_EVENTS.WEAPON_SHOT_SKILLS,handler(self,self._useSkills))
    global.shotMgr:registerFn(GAME_EVENTS.RESTART_GAME_TEST,handler(self,self._restartGame))
    global.shotMgr:registerFn(GAME_EVENTS.OPEN_BAOYI_EVENT,handler(self,self._openBaoYi))
    global.shotMgr:registerFn(GAME_EVENTS.CLOSE_BAOYI_EVENT,handler(self,self._closeBaoYi))
    
end

function FightWnd:_openBaoYi()
	if not self.m_baoyi_ui then
        self.m_baoyi_ui = require("game.modules.shotting.BaoYiUi").new()
        self:addChild(self.m_baoyi_ui)
	end
	
    global.effectMgr:pause()
    global.objMgr:pause()
end

function FightWnd:_closeBaoYi()
	if self.m_baoyi_ui then
	    self.m_baoyi_ui:clear()
        self.m_baoyi_ui:removeFromParent()
        self.m_baoyi_ui = nil
	end
	
    global.effectMgr:resume()
    global.objMgr:resume()
end

function FightWnd:_changeManDirMove(dir,moveDir,actionName)
    if global.currentPlayer then
        global.currentPlayer:setMoveDirection(dir,moveDir,actionName)
    end
end

function FightWnd:_restartGame()
	global.objMgr:clearObjects()
	global.currentPlayer = nil
    self:_testx()
end

function FightWnd:_testx()
--    local monster_pos = {{863.9,110.6},{828.6,21.4},{1060.8,64.9}}
    
--    --- 新建怪物
--    for i= 1,3 do
--        local monster = global.objMgr:createCreatureByProto("8_1")
--        local s = monster_pos[i]
--        monster:setPosition(s[1],s[2])
--    end
    
--    local xianjing_pos = {{538.3,160.3},{530.0,50.4},{1276.5,143.7},{1201.8,38.0}}
--    for i = 1,4 do
--    	local xianjing = global.objMgr:createCreatureByProto("9_1")
--    	local s = xianjing_pos[i]
--    	xianjing:setPosition(s[1],s[2])
--    end

--    local boss = global.objMgr:createCreatureByProto("7_1")
--    boss:setPosition(1749.3,29.7)
    
--    self.shotMan = global.objMgr:createCreatureByProto("1_1")
--    self.shotMan:setPosition(194.1,102.3)
--    global.currentPlayer = self.shotMan
    
--    self.currentWeapon = global.objMgr:createWeaponByID("1_1")
--    self.currentWeapon:setPosition(cc.p(30,50))
--    global.currentPlayer:getResCCB():addChild(self.currentWeapon)
    
--    local dot = ccui.Scale9Sprite:create("scale_9.png")
--    dot:setContentSize(cc.size(50,50))
--    dot:setPosition(cc.p(center_x,center_y))
--    global.sceneMgr:getLayer(LAYER_TYPE.LOADING_LAYER):addChild(dot)
--    global.dot = dot 
   
--    local dot = ccui.Scale9Sprite:create("scale_9.png")
--    dot:setContentSize(cc.size(define_w,define_h))
--    dot:setPosition(cc.p(center_x,center_y))
--    global.sceneMgr:getLayer(LAYER_TYPE.LOADING_LAYER):addChild(dot)
--    global.dots = dot
end

function FightWnd:_useSkills(skillid)
    if global.currentPlayer then
        global.currentPlayer:useSkillAttack(skillid.."")
    end
    
--    global.effectMgr:pause()
--    global.objMgr:pause()
--    self:_openBaoYi()
end

function FightWnd:clear()
    global.shotMgr:unRegisterFn(GAME_EVENTS.CHANGE_SHOT_MAN_DIR)
    global.shotMgr:unRegisterFn(GAME_EVENTS.WEAPON_SHOT_SKILLS)
    global.shotMgr:unRegisterFn(GAME_EVENTS.RESTART_GAME_TEST)
    global.shotMgr:unRegisterFn(GAME_EVENTS.OPEN_BAOYI_EVENT)
    global.shotMgr:unRegisterFn(GAME_EVENTS.CLOSE_BAOYI_EVENT)

    global.mapMgr:leaveMap()
    
    global.popWndMgr:close(SHOT_WNDS.FIGHT_UI)
    global.popWndMgr:close(SHOT_WNDS.ROCKER_WND)
end

return FightWnd