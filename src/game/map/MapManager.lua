--
-- Author: dawn
-- Date: 2014-09-29 00:31:55
--

local MapManager = class("MapManager")

function MapManager:ctor( )	
end

function MapManager:joinMap(id)
    self.currentScreenID = 1        -- 当前第一屏
    self.m_data = global.dataMgr:getConfigDatas("map_config",id)
	self.map_id = id
	self:leaveMap()
	self:_loadMap(self.map_id)
end

function MapManager:getMapData()
    return self.m_data
end

function MapManager:leaveMap()
    self:_clear()
end

function MapManager:getMapID()
	return self.map_id
end
function MapManager:_loadMap(id )
	 self.m_map = require("game.map.TileMap").new(id)
	 self.m_map:setPosition(0,0)
	 global.sceneMgr:getMapLayer(MAP_TYPE.MAP_BG_LAYER):addChild(self.m_map)
end

function MapManager:getMap()
    return self.m_map
end

function MapManager:getCurrentMap()
    local layer = global.sceneMgr:getLayer(LAYER_TYPE.MAP_LAYER)
    return layer
end

function MapManager:setScreenID(id)
	self.currentScreenID = id
end

function MapManager:setLockMap(s)
	self.m_map:setLockMapScreen(s)
end

function MapManager:getScreenID()
    return self.currentScreenID
end

function MapManager:getCurrentMapWidth()
    return self.m_map:getW()
end

function MapManager:getCurrentMapHeight()
    return self.m_map:getH()
end

function MapManager:getCurrentMoveSpeed()
	return self.m_map:getMoveSpace()
end

function MapManager:_clear()
	if self.m_map then
		self.m_map:clear()
		self.m_map:removeFromParent()
		self.m_map = nil
	end
end

return MapManager