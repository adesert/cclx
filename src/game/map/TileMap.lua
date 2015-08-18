
local TileMap = class("TileMap",require("game.base.BaseLayer"))

function TileMap:ctor(id)
    self.m_map_id = id
    self.m_map_data = global.dataMgr:getConfigDatas("map_config",id)
    self.m_temp_width = nil
    self.m_temp_move_width = nil
	self.super.ctor(self)
end

function TileMap:_overrideInit()
--    local mapID = "map_"..self.m_map_id
    local mapID = self.m_map_data["res"]
    local path = global.pathMgr:getMapTmx(mapID)
    self.map = cc.TMXTiledMap:create(path)
    self:addChild(self.map)
    
    local layerModel = self.map:getLayer("layer_bg")
    local proerys = layerModel:getProperties()
    self.m_width = tonumber(proerys["width"])
    self.m_height = tonumber(proerys["height"])
        
--    self.lv_dic = self.map:getObjectGroup("layer_effect")--TMXObjectGroup
--    local objs = self.lv_dic:getObjects()
--    for key, var in pairs(objs) do
--    	local vx = var.x
--    	local vy = var.y
--    	local name = var.name
--    	local sp = cc.Sprite:create(global.pathMgr:getMap(name))
--    	sp:setAnchorPoint(cc.p(0,0))
--    	sp:setPosition(cc.p(tonumber(vx),tonumber(vy)))
--    	self.map:addChild(sp)
--    end
    
    self.lv_dic = self.map:getObjectGroup("move_space")
    objs = self.lv_dic:getObjects()
    for key, var in pairs(objs) do
    	if var.name == "space" then
    	   self.move_space = cc.rect(tonumber(var.x),tonumber(var.y),tonumber(var.width),tonumber(var.height))
    	   break
    	end
    end
    
    local parse_id = self.m_map_data["parse_id"]
    self.levelConfigs = require("game.map.levels.LevelFact").getLevelsByID(parse_id)
    self.levelConfigs:parseMapData(self.m_map_data)
    
    self.frameHandler = SCHE_MGR.scheduleUpdateGlobal(handler(self,self._updateHandler))
    
    self.m_temp_width = self.m_width
    self.m_temp_move_width = self.move_space.width
    
    self:_initTileMapTimeUpdate()
end

function TileMap:_initTileMapTimeUpdate()
    local id = self.m_map_id
    local config = global.dataMgr:getConfigDatas("level_w_config",id)
    
    local t = tonumber(config.level_time)
    if t<=0 then
        return
    end
    
    self.levelTime = t
    global.shopMgr:applyFn(GAME_EVENTS.UPDATE_LEVEL_LEFT_TIME,self.levelTime)
    self.tiledMapTimer = SCHE_MGR.scheduleGlobal(handler(self,self._updateTimer),1)
end

function TileMap:_updateTimer()
    if self.levelTime <=0 then
        global.shopMgr:applyFn(GAME_EVENTS.UPDATE_LEVEL_LEFT_TIME,self.levelTime)
        if self.tiledMapTimer then
            SCHE_MGR.unscheduleGlobal(self.tiledMapTimer)
            self.tiledMapTimer = nil
        end
        return
    end
    global.shopMgr:applyFn(GAME_EVENTS.UPDATE_LEVEL_LEFT_TIME,self.levelTime)
    self.levelTime = self.levelTime -1
end

function TileMap:_updateHandler()
	if self.levelConfigs then
	   self.levelConfigs:handler()
	end
end

function TileMap:getMoveSpace() -- 可行走区域
    local vx,vy = self:getPosition()
    self.move_space.x = vx
    return self.move_space
end

function TileMap:setMoveSpaces(w)
	self.move_space.width = w
end

function TileMap:setMapWidth(w)
    self.m_width = w
end

function TileMap:setLockMapScreen(s)
    if s== true then
        self:setMoveSpaces(define_w)
        self:setMapWidth(define_w)
    elseif s== false then
        self:setMoveSpaces(self.m_temp_width)
        self:setMoveSpaces(self.m_temp_move_width)
    end
    
    self.m_lock = s
end

function TileMap:getLockState()
    return self.m_lock
end

function TileMap:_getCounts(t)
    local objs = t:getObjects()
    local n = table.nums(objs) 
    return n
end

function TileMap:getMapID()
	return self.m_map_id
end

function TileMap:getW()
    return self.m_width
end

function TileMap:getH()
    return self.m_height
end

function TileMap:clear()
	if self.frameHandler then
        SCHE_MGR.unscheduleGlobal(self.frameHandler)
        self.frameHandler = nil
	end
	
	if self.tiledMapTimer then
	   SCHE_MGR.unscheduleGlobal(self.tiledMapTimer)
	   self.tiledMapTimer = nil
	end
	
    if self.levelConfigs then
        self.levelConfigs:clear()
    end
end

return TileMap