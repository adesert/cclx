
local FMap = class("FMap",require("game.base.BaseLayer"))

function FMap:ctor()
	self.super.ctor(self)
	self:_init()
end

function FMap:_init()
    self.map = require("game.modules.fight.map.MapFac").getMapById(2)
    self:addChild(self.map)
    
    global.fightMgr:registerFn(KONG_EVNET.UPDATE_MAP_MOVE_DIR,handler(self,self._updateDir))
    global.fightMgr:registerFn(KONG_EVNET.UPDATE_MAP_MAP_END_DIR,handler(self,self._updateDirEnd))
end

function FMap:_updateDir(dir,moveDir,actionName)
    self.map:updateDir(dir,moveDir,actionName)
end

function FMap:_updateDirEnd(dir,moveDir,actionName)
    self.map:updateDirEnd(dir,moveDir,actionName)
end

function FMap:clear()
    self.map:clear()
    global.fightMgr:unRegisterFn(KONG_EVNET.UPDATE_MAP_MOVE_DIR)
    global.fightMgr:unRegisterFn(KONG_EVNET.UPDATE_MAP_MAP_END_DIR)
end

return FMap