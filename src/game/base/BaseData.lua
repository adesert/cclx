--数据类
local BaseData = class("BaseData")

function BaseData:ctor()
	self.m_data = {}
end

function BaseData:update(attr,value)
	self.m_data[attr] = value
end

function BaseData:get(attr)
	return self.m_data[attr]
end

function BaseData:clone()
	local data  = BaseData:new()
	for k,v in pairs(self.m_data)	do
		if type(v) ~= "table" then
			data.m_data[k] = v
		else
			data.m_data[k] = {}
			for kk,vv in pairs(v) do
				data.m_data[k][kk] = vv
			end
		end
	end
	return data
end

------------------------------ 设置 ----------------------------
function BaseData:setCreatureData(id)
    local config = global.dataMgr:getConfigDatas("level_config",id)
    self:update(ATTR_DEFINE.TYPE,tonumber(config.type))
    self:update(ATTR_DEFINE.SPEED,tonumber(config.speed))
--    self:update(ATTR_DEFINE.HDX,tonumber(config.hdx))
    self:update(ATTR_DEFINE.SKILLS,config.skills)
    self:update(ATTR_DEFINE.AI_TYPE,tonumber(config.ai_type))
    
    local model_config = global.dataMgr:getConfigDatas("model_config",config.model_id)
    self:update(ATTR_DEFINE.CCB,model_config.model_name)
    self:update(ATTR_DEFINE.NAME,model_config.name)
    self:update(ATTR_DEFINE.ICON,model_config.icon)
    self:update(ATTR_DEFINE.HALF_ICON,model_config.half_icon)
    self:update(ATTR_DEFINE.MODEL_ID_X,config.model_id)
    
    self:update(ATTR_DEFINE.ID,global.objMgr:genId())
end

function BaseData:setWeaponData(id)
--    local config = global.dataMgr:getConfigDatas("weapon_config",id)
--    self:update(ATTR_DEFINE.CCB,config.model_name)
--    self:update(ATTR_DEFINE.WEAPON_ATTACK_VALUE,tonumber(config.attack_value))
--    self:update(ATTR_DEFINE.WEAPON_CRIT_VALUE,tonumber(config.crit_value))
--    self:update(ATTR_DEFINE.WEAPON_ZI_DAN,tonumber(config.zidan_counts))
--    self:update(ATTR_DEFINE.WEAPON_SKILL_ID,config.skill_id)
    
    local model_config = global.dataMgr:getConfigDatas("model_config",id)
    self:update(ATTR_DEFINE.CCB,model_config.model_name)
end

--function BaseData:setWeaponDatas(id)
--    local model_config = global.dataMgr:getConfigDatas("model_config",id)
--end

---------------------------------------------->>>>>>>>>>>>>>>>>>>>>
---- 模型数据
--function BaseData:setmodelProto(key )
--	local config = global.proto.model_config(key)
--	self:update(ATTR_DEFINE.MODEL_ID,key)
--	self:update(ATTR_DEFINE.CCB,config.ccb)
--	self:update(ATTR_DEFINE.COLLIDER_Y,config.collider_y)
--	self:update(ATTR_DEFINE.ICON,config.head_icon)
--	self:update(ATTR_DEFINE.HALF_ICON,config.half_body_icon)
--end
--
----英灵模板
--function BaseData:setHeroProto( key )
--	local config = global.proto.hero_proto(key)
--	self:update(ATTR_DEFINE.ID,global.objMgr:genId())
--	self:setmodelProto(config.model_id)
--	self:update(ATTR_DEFINE.NAME,config.name)
--	self:update(ATTR_DEFINE.CLASS,config.class)
--	self:update(ATTR_DEFINE.SKILLS,config.skills)
--	-- self:update(ATTR_DEFINE.TYPE,config.type)
--	self:update(ATTR_DEFINE.TYPE,CREATURE_TYPE.HERO)
--	self:update(ATTR_DEFINE.NORMAL_SKILLS,config.normal_skills)
--end

return BaseData