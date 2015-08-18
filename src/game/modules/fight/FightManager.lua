
local FightManager = class("FightManager",require("game.managers.BaseManager"))

function FightManager:ctor()
	self.super.ctor(self)
	self:_init()
end

function FightManager:_init()
    global.popWndMgr:register(KONG_WNDS.FIGHT_LAYER,handler(self,self._openFightUI),handler(self,self._closeFightUI))
end

function FightManager:_openFightUI()
    if not self.m_fight_layer then
        self.m_fight_layer = require("game.modules.fight.FightLayer").new()
        global.sceneMgr:getLayer(LAYER_TYPE.MAIN_UI_LAYER):addChild(self.m_fight_layer)
    end
end

function FightManager:_closeFightUI()
    if self.m_fight_layer then
        self.m_fight_layer:clear()
        self.m_fight_layer:removeFromParent()
        self.m_fight_layer=nil
    end
end

return FightManager