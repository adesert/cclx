
--[[
    关卡地图
]]--

local LevelMapManager = class("LevelMapManager",require("game/managers/BaseManager"))

function LevelMapManager:ctor()
    self.super.ctor(self)
    
    self:_init()
end

function LevelMapManager:_init()
    global.popWndMgr:register(WND_NAME.LEVEL_MAP,handler(self,self._openMap),handler(self,self._closeMap))
end

function LevelMapManager:_openMap()
	if not self.map then
	   self.map = require("game.modules.map.LevelMap").new()
	   global.sceneMgr:getLayer(LAYER_TYPE.MAP_LAYER):addChild(self.map)
	end
end

function LevelMapManager:_closeMap()
	if self.map then
	   self.map:clear()
	   self.map:removeFromParent()
	   self.map = nil
	end
end

return LevelMapManager