--
-- Author: dawn
-- Date: 2014-10-30 17:20:48
--
local TileMap = class("TileMap", function ( )
	return cc.Layer:create()
end)

function TileMap:ctor(id,data)
	self.m_id = id
	self.m_data = data
	self.map = nil 							-- tile map
	self.txm_name = "MapZone_" .. self.m_id
	self:_init()
end

function TileMap:_init()
	-- print(self.txm_name)
    self.map = cc.TMXTiledMap:create(global.pathMgr:getTileMapTmx(self.txm_name))
	self:addChild(self.map)
	
	self.map_img = cc.Sprite:create(global.pathMgr:getMainMapImg("Map_BackStar_" .. self.m_id))
	self.map_img:setAnchorPoint(cc.p(0,0))
	self.map:addChild(self.map_img)

    self.lv_dic = self.map:getObjectGroup("MapLevels")--TMXObjectGroup
	local counts = self:_getCounts(self.lv_dic)
	local nor_data = self.m_data["normal_level"]

	for i=1,counts do
        local cell = self.lv_dic:getObject(tostring(i))
        local vx = cell.x --name,type,width,height,gid,x,y
		local vy = cell.y
		
		local t = nor_data["level_"..i]
		local lv_item = require("game.modules.mainui.item.LevelItem").new(self.m_id,i)
		lv_item:setData(t)
		lv_item:setPosition(tonumber(vx),tonumber(vy))
		self.map:addChild(lv_item)
	end
	
	local boss_data = self.m_data["boss_level"]

    self.mapStation = self.map:getObjectGroup("MapStation")--CCTMXObjectGroup
	counts = self:_getCounts(self.mapStation)
	for i=1,counts do
        local cell = self.mapStation:getObject(tostring(i))
		local vx = cell.x
		local vy = cell.y
		
		local t = boss_data["level_"..i]
		local boss_icon = require("game.modules.mainui.item.LevelStation").new(self.m_id,i,t)
		boss_icon:setPosition(tonumber(vx),tonumber(vy))
		self.map:addChild(boss_icon)
	end

    self.levelsPath = self.map:getObjectGroup("LevelsPath")
	counts = self:_getCounts(self.levelsPath)
	for i=1,counts do
        local cell = self.levelsPath:getObject(tostring(i))
		local vx = cell.x
		local vy = cell.y
        local sp = cc.Sprite:create(global.pathMgr:getMainMapImg("MapWayPoint"))
		sp:setAnchorPoint(cc.p(0,0))
		sp:setPosition(tonumber(vx),tonumber(vy))
		self.map:addChild(sp)
	end

    self.stationPath = self.map:getObjectGroup("StationPath")
	counts = self:_getCounts(self.stationPath)
	
	for i=1,counts do
        local cell = self.stationPath:getObject(tostring(i))
		local vx = cell.x
		local vy = cell.y
        local sp = cc.Sprite:create(global.pathMgr:getMainMapImg("MapSpace_WayPoint"))
		sp:setAnchorPoint(cc.p(0,0))
		sp:setPosition(tonumber(vx),tonumber(vy))
		self.map:addChild(sp)
	end
end

function TileMap:_getCounts(t)
--	local n = 1
	local objs = t:getObjects()
    local n = table.nums(objs) 
	print("-------a----a----a---",n)
	return n
--	local obj = t:getObject(tostring(n))
--	while obj  do
--		n = n+1
--		obj = t:getObject(tostring(n))
--		print(obj)
--	end
--	return n-1
end

function TileMap:getW( )
	return self.map:getContentSize().width
end

function TileMap:getH( )
	return self.map:getContentSize().height
end

return TileMap