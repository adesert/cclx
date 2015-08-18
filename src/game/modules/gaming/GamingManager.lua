--
-- Author: dawn
-- Date: 2014-10-31 17:59:39
--
local GamingManager = class("GamingManager", require("game.managers.BaseManager"))
require("game/modules/gaming/LevelConst")

function GamingManager:ctor( )
    self.super.ctor(self)
	self:_init()
end

function GamingManager:_init( )
	global.popWndMgr:register(GAING_ON_UI, handler(self,self._openGameUI),handler(self, self._closeGameUI))
    self:registerFn(LEVEL_EVENT.COLLISION_EVENTS,handler(self,self._ballConcateEvent))
    global.popWndMgr:register(WND_NAME.FIGHTING_IN,handler(self,self._openFightOn),handler(self,self._closeFightOn))
    
end

function GamingManager:_openFightOn(id)
    if not self.m_fighting then
        self.m_fighting = require("game.modules.gaming.FightingIn").new(id)
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_fighting)
    end
end

function GamingManager:_closeFightOn()
    if self.m_fighting then
        self.m_fighting:clear()
        self.m_fighting:removeFromParent()
        self.m_fighting = nil
    end
end

function GamingManager:_openGameUI( )
	if not self.m_on_ui then
		self.m_on_ui = require("game.modules.gaming.GamingUI").new()
		global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_on_ui)
	end
end

function GamingManager:_closeGameUI( )
	if self.m_on_ui then
		self.m_on_ui:removeFromParent()
		self.m_on_ui = nil
	end
end

------------------------------------------------  处理小球之间的碰撞 -----------------------------------
function GamingManager:_ballConcateEvent(bodyA,bodyB,type)
    if true then
        return
    end
    
    local atype = bodyA:getType()
    local btype = bodyB:getType()
    local body = nil
    if atype == BARRYS_TYPE.BALL_TYPE then
        body = bodyB
    else
        body = bodyA
    end
    
    if body then
        if type == COLLISION_EVENT.SEPERATE then
            body:seperateHandler()
        else
            body:collisionHandler()
        end
    end
    
--    if type == COLLISION_EVENT.SEPERATE then
--        bodyA:seperateHandler()
--        bodyB:seperateHandler()
--    else
--        bodyA:collisionHandler()
--        bodyB:collisionHandler()
--    end
end

return GamingManager