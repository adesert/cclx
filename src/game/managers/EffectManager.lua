--特效管理类
local EffectManager = class("EffectManager")

function EffectManager:ctor()
	self.m_effs = {}				--特效
	self.m_schedule_handle = 0
end

--开始渲染特效
function EffectManager:start()
    self.m_schedule_handle = SCHE_MGR.scheduleUpdateGlobal(handler(self,self._render))
end

--停止渲染特效
function EffectManager:stop()
    SCHE_MGR:unscheduleGlobal(self.m_schedule_handle)
	self.m_schedule_handle = 0
end

-- 所有特效暂停
function EffectManager:pause()
	for k,v in pairs(self.m_effs) do 
		v:pause()
	end
end

-- 所有特效恢复播放
function EffectManager:resume()
	for k,v in pairs(self.m_effs) do
		v:resume()
	end
end

--得到所有objects
function EffectManager:getAllObjects()
    return self.m_effs
end

--检查特效是否C++对象不存在
function EffectManager:checkIsCNull(v)
	if tolua.isnull(v) then
		v.m_state = EFFECT_STATE.RUBBISH
		return true
	end
end

--渲染特效的函数
function EffectManager:_render(duration, curTime)
	for i=#self.m_effs,1,-1 do
		local v = self.m_effs[i]
		if not self:checkIsCNull(v) then
			if v:getState() == EFFECT_STATE.READY then
				v:renderCallbacks(EFFECT_CALLBACK.BEGIN)
				v:setState(EFFECT_STATE.RUNING)
			elseif v:getState() == EFFECT_STATE.RUNING then
			     if v:isRunning() then
                    v:update(duration, curTime)
                    if v:getEffectType() ~= EFFECT_TYPE.COMMON_EFFECT then
                        v:setZOrder(v:getDepth())
                    end
			     end
				if v:isRunning() == nil then
					v:setState(EFFECT_STATE.RUBBISH)
				else
					if not v:isRunning() then
						v:renderCallbacks(EFFECT_CALLBACK.END)
						v:setState(EFFECT_STATE.RUBBISH)
					end
				end
			elseif v:getState() == EFFECT_STATE.RUBBISH then
				table.remove(self.m_effs,i)
				self:_disposeEffect(v)
			end
		end
	end
end

--销毁一个特效（该方法只能在effect_manager内部调用）如果想手动消除某个特效 设置其状态为rubish
function EffectManager:_disposeEffect(eff)
	if not tolua.isnull(eff) then
	    eff:clear()
		eff:removeFromParent()
	end
	eff = nil
end

--创建一个基础特效
function EffectManager:createCommonEffect(id,parent,m_creature)
    local eff = require("game.creature.BaseEffect").new(id,parent,m_creature)
    eff:setEffectType(EFFECT_TYPE.COMMON_EFFECT)
    table.insert(self.m_effs,eff)
    return eff
end

-- 创建一个技能特效
function EffectManager:createSkillEffect(id,parent,creature)
    local data = global.dataMgr:getConfigDatas("skill_config",id)
    local type = tonumber(data["type"])
    local eft = nil
    local effectid = data.effect
    if type == EFFECT_TYPE.SKILL_EFFECT then
        eft = require("game.creature.SkillEffect").new(effectid,parent,creature)
    elseif type == EFFECT_TYPE.VITRO_EFFECT then
        eft = require("game.creature.Vitro").new(effectid,parent,creature)
    elseif type == EFFECT_TYPE.CHUANSONGMEN_EFFECT then
        eft = require("game.creature.ChuanSongMenEffect").new(effectid,parent,creature)
    end
    eft:setEffectType(type)
    table.insert(self.m_effs,eft)
    return eft
end

--创建一个自定义特效 parent 是父对象
--function EffectManager:createSelfDefineEff(id,parent)
--	local eff = require("game.creature.BaseEffect").new(id,nil,parent)
--	table.insert(self.m_effs,eff)
--	return eff
--end

-- 创建一个技能特效
--function EffectManager:createSkillEffect(id,parent,creature)
--	local eff = require("game.creature.BaseEffect").new(id,parent,creature)
--	table.insert(self.m_effs,eff)
--	return eff
--end

--function EffectManager:createVitroEffect(id,parent,creature)
--    local eff = require("game.creature.Vitro").new(id,parent,creature)
--    table.insert(self.m_effs,eff)
--    return eff
--end
--
--function EffectManager:createMonsterVitroEffect(id,parent,creature)
--	local eff = require("game.creature.MonsterVitro").new(id,parent,creature)
--	table.insert(self.m_effs,eff)
--	return eff
--end

--function EffectManager:createCommonEffect(id,parent,creature)
--	local eff = require("game.creature.BaseEffect").new(id,parent,creature)
--    table.insert(self.m_effs,eff)
--    return eff
--end

--- 技能特效
--function EffectManager:createSkillEffectByID(id,parent,creature)
--    local eff = require("game.creature.SkillEffect").new(id,parent,creature)
--    table.insert(self.m_effs,eff)
--    return eff
--end

-- 清除所有特效
function EffectManager:clearAllEffect()
	for k,v in pairs(self.m_effs) do
		self:_disposeEffect(v)
	end
	self.m_effs = {}
end

return EffectManager