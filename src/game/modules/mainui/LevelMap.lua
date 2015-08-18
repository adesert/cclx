--
-- Author: dawn
-- Date: 2014-10-30 14:54:28
--
local LevelMap = class("LevelMap",function ( )
	return cc.Layer:create()
end)

function LevelMap:ctor()
    cc.SpriteFrameCache:getInstance():addSpriteFrames("img/common/_MainMap_Ch.plist","img/common/_MainMap_Ch.png")
    
	self.mapDic = {}
	self.moveSign = true
	self.m_dir = 0

	self:_initData()
	self:_init()	
	self:_registerFn()
end

function LevelMap:_initData()
--	self.levelData = global.gameStateMgr:getData(MAP_DATA)
--	if not self.levelData then
--		self.levelData = global.proto.get_level_config()
--	end
    self.levelData = global.proto.get_level_config()
end

function LevelMap:_registerFn()
    node_touchEvent(self,handler(self,self._touchBegan),handler(self,self._touchMoved),handler(self,self._touchEnded),nil)
    
	self.frameHandler = SCHE_MGR.scheduleUpdateGlobal(handler(self, self._frameFunc))
end

function LevelMap:_init()
	self.map = cc.Layer:create()
	self:addChild(self.map)
	
	local mapX = 0
	local counts = table.nums(self.levelData)
	for i=1,counts do
		local datas = self.levelData["layer_"..i]
		local tile = require("game.modules.mainui.TileMap").new(i,datas)
		local ww = tile:getW()
		tile:setPosition(mapX, 0)
		self.map:addChild(tile)
		tile:setLocalZOrder(100-i)
		self.mapDic["map_" .. i] = tile
		mapX = mapX + ww
	end
	self.mapW = mapX --10560
	self.mapH = 640
end

function LevelMap:_frameFunc()
	if true then
		return
	end
	-----------------------------
	if self.moveSign == true then
		return
	end
	local vx = self.map:getPositionX()

	if self.m_dir == 0 then
        if vx + self.mapW <= screen_right then
			return
		end
		self.map:setPositionX(vx+self.m_speed)
	else
		if vx >= screen_left then
			return
		end
		self.map:setPositionX(vx+self.m_speed)
	end
end

--function LevelMap:_touchFn(evt)
--	if evt.name == "began" then
--		self:_touchBegan(evt)
--		return true
--	elseif evt.name == "moved" then
--		self:_touchMoved(evt)
--	elseif evt.name == "ended" then
--		self:_touchEnded(evt)
--	elseif evt.name == "cancelled" then
--		self:_touchEnded(evt)
--	end
--end

function LevelMap:_touchBegan(touch,event)
    local location = touch:getLocation()
	self.m_speed = 0
	self.prevX = location.x
    self.prevY = location.y
	self.moveSign = false
	return true
end

function LevelMap:_touchMoved(touch,event)
    local location = touch:getLocation()
    local prepox = touch:getPreviousLocation()
    self.moveX = location.x - prepox.x
    self.moveY = location.y - prepox.y
	local vx = self.map:getPositionX()
    if location.x > prepox.x then
		self.m_dir = 1
		self.m_speed = 5
		if vx+self.moveX >= screen_left then
			return
		end
	else
		self.m_dir = 0
		self.m_speed = -5
		if vx+self.moveX + self.mapW <= screen_right then
			return
		end
	end
	
	self.map:setPositionX(vx+self.moveX)
end

function LevelMap:_touchEnded(evt)
	self.moveSign = true
end

function LevelMap:clear()
    SCHE_MGR.unscheduleGlobal(self.frameHandler)
end

return LevelMap

