--
-- Author: dawn
-- Date: 2014-10-10 18:17:33
--
local ObjectsManager = class("ObjectsManager")

MAX_ID_INDEX = 1000000

function ObjectsManager:ctor()
	self.m_id_index = 0
	self.m_objects = {}
	self.m_schedule_handle = 0
end

function ObjectsManager:start()
	self.m_schedule_handle = SCHE_MGR.scheduleUpdateGlobal(handler(self,self._render))
end

function ObjectsManager:stop()
	SCHE_MGR.unscheduleGlobal(self.m_schedule_handle)
	self.m_schedule_handle = 0
end

function ObjectsManager:pause()
    for key, var in pairs(self.m_objects) do
		var:pause()
	end
end

function ObjectsManager:resume()
	for kety, var in pairs(self.m_objects) do
		var:resume()
	end
end

--生物更新逻辑
function ObjectsManager:_render(duration, curTime)
	for k,v in pairs(self.m_objects) do
		v:onUpdate(duration, curTime)
		v:setZOrder(v:getDepth())
	end
end

function ObjectsManager:createObjectByData(data,parent)
	local obj
    local type = data:get(ATTR_DEFINE.TYPE)
    if type == CREATURE_TYPE.PLAYER then
        obj =  require("game.creature.Player").new(data)
	elseif type == CREATURE_TYPE.MONSTER then
        obj = require("game.creature.Monster").new(data)
    elseif type == CREATURE_TYPE.BOSS then
        obj = require("game/creature/Boss").new(data)
    elseif type == CREATURE_TYPE.XIANJING then
        obj = require("game.creature.XianJing").new(data)
    else
        obj = require("game.creature.BaseObject").new(data)
	end
	obj:init()
	local id = obj:getAttr(ATTR_DEFINE.ID)
	self.m_objects[id] = obj
	
	if not parent then
        parent = global.sceneMgr:getMapLayer(MAP_TYPE.THINGS_LAYER)
	end
	parent:addChild(obj)
	return obj
end

--- 创建生物
function ObjectsManager:createCreatureByProto(id,parent)
	local data = require("game.base.BaseData").new()
	data:setCreatureData(id)
    return self:createObjectByData(data,parent)
end

--- 创建一个武器
function ObjectsManager:createWeaponByID(id)
    local data = require("game.base.BaseData").new()
    data:setWeaponData(id)
    local weapon = require("game.creature.BaseWeapon").new(data)
    weapon:init()
    return weapon
end

--得到所有objects
function ObjectsManager:getAllObjects()
	return self.m_objects
end

--得到某个实体
function ObjectsManager:getObject(id)
	return self.m_objects[id]
end

--生成id
function ObjectsManager:genId()
	if self.m_id_index > MAX_ID_INDEX then
		self.m_id_index = 0
	end
	self.m_id_index = self.m_id_index + 1
	if self.m_objects[self.m_id_index] == nil then
		return self.m_id_index
	else
		self:genId()
	end
end

function ObjectsManager:destroyObject(id)
	if self.m_objects[id] == nil then
		return
	else
	    self.m_objects[id]:clear()
		self.m_objects[id]:removeFromParent()
		self.m_objects[id] = nil
	end
end

function ObjectsManager:clearObjects()
	for k,v in pairs(self.m_objects) do 
		self:destroyObject(v:getAttr(ATTR_DEFINE.ID))
	end
end


return ObjectsManager