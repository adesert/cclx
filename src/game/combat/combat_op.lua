
combat_op = {}

-- 伤害结算,技能特效伤害结算 （特效 attack）
function combat_op.handleAttackByAirto(effect,i)
    print("combat_op.handleAttackByAirto",effect,i)
end

--- 武器发射子弹
function combat_op.handleWeaponFunc(weapon)
    local owner = weapon:getCreature()
    local skillid = owner:getAttr(ATTR_DEFINE.SKILLID)
    local config = global.dataMgr:getConfigDatas("skill_config",skillid)
    local feffect = config.feffect;
    if feffect == "0" then
        return
    end    
    
    local owner = weapon:getCreature()
    local ox,oy = owner:getPosition()
    local dir = owner:getDirection()
    local feffectID = feffect[1]
    local pox = tonumber(feffect[2])+ox
    local poy = tonumber(feffect[3])+oy
    
    if dir == DIRECTION.LEFT then
        pox = -tonumber(feffect[2])+ox
    end
    
    local skill_config = global.dataMgr:getConfigDatas("skill_config",skillid)
--    local dir  = m_owner:getDirection()
--    local m_parent = global.sceneMgr:getLayer(LAYER_TYPE.THINGS_LAYER)
    local m_parent = global.sceneMgr:getMapLayer(MAP_TYPE.THINGS_LAYER)
    local skill_type = tonumber(skill_config.type)
    if skill_type == EFFECT_TYPE.COMMON_EFFECT then

    elseif skill_type == EFFECT_TYPE.COMMON_NO_EFFECT then

    elseif skill_type == EFFECT_TYPE.SKILL_EFFECT then
    
    elseif skill_type == EFFECT_TYPE.VITRO_EFFECT then
        local skill = global.effectMgr:createCommonEffect(feffectID,m_parent,owner)
        skill:play()
        skill:setPosition(cc.p(pox,poy))
        print(pox,poy)
        skill:setDirection(dir)
    end
end

--- 发射子弹,播放发射子弹的特效
function combat_op.handlerShotZiDanFunc(effect)
    local owner = effect:getOwner()
    local skillid = owner:getAttr(ATTR_DEFINE.SKILLID)
--    local m_parent = global.sceneMgr:getLayer(LAYER_TYPE.THINGS_LAYER)
    local m_parent = global.sceneMgr:getMapLayer(MAP_TYPE.THINGS_LAYER)
    local config = global.dataMgr:getConfigDatas("skill_config",skillid)
    local pos = config["posxy"]
    local vx = tonumber(pos[1]);
    local vy = tonumber(pos[2]);
    local dir = owner:getDirection()
    local ox,oy = owner:getPosition()
    if dir == DIRECTION.LEFT then
    	vx = -vx
    end
    vx = vx+ox
    vy = vy+oy
    local skill = global.effectMgr:createSkillEffect(skillid,m_parent,owner)
    skill:play()
    skill:setPosition(cc.p(vx,vy))
    skill:setDirection(dir)
end

-- 技能攻击,检测碰撞 飞行特效碰撞检测
function combat_op.handleAttackSkillsEffect(effect)
    
--    if true then
--        return
--    end
    
    print("handleAttackSkillsEffect",effect)
    
    local isCollsion = false
    local objs = {}
    local t = global.objMgr:getAllObjects()
    
    for key, var in pairs(t) do
        local type = var:getAttr(ATTR_DEFINE.TYPE)
        local actionName = var:getAction()
        local typeEft = effect:getOwner():getAttr(ATTR_DEFINE.TYPE)
        
        local isMonster = false
        if typeEft == CREATURE_TYPE.MONSTER or typeEft == CREATURE_TYPE.BOSS then
            if type == CREATURE_TYPE.MONSTER or type == CREATURE_TYPE.BOSS then
                isMonster = true
            end
        end
        
        local isXianJing = false
        if type == CREATURE_TYPE.XIANJING or typeEft == CREATURE_TYPE.XIANJING then
            isXianJing = true
        end
        
        if type ~= typeEft and isMonster == false and isXianJing == false and actionName ~= CREATURE_ACTION_NAME.DIE then
            local vx,vy = effect:getAttackCollision():getPosition()
            local vp = effect:convertToWorldSpace(cc.p(vx,vy))
            local rect = effect:getAttackCollision():getBoundingBox()
            local effectCollsion = cc.rect(vp.x,vp.y,rect.width,rect.height)
            
            vx,vy = var:getAttackedCollision():getPosition()
            vp = var:convertToWorldSpace(cc.p(vx,vy))
            rect = var:getAttackedCollision():getBoundingBox()
            local creatureCollsion = cc.rect(vp.x,vp.y,rect.width,rect.height)
            
            local effect_rect = {
                x = effectCollsion.x,
                y = effectCollsion.y,
                width = effectCollsion.width,
                height = effectCollsion.height,
                min_x = effectCollsion.x-effectCollsion.width/2,
                min_y = effectCollsion.y - effectCollsion.height/2,
                max_x = effectCollsion.x+effectCollsion.width/2,
                max_y = effectCollsion.y+effectCollsion.height/2,
            }

            local creature_rect = {
                x = creatureCollsion.x,
                y = creatureCollsion.y,
                width = creatureCollsion.width,
                height = creatureCollsion.height,
                min_x = creatureCollsion.x - creatureCollsion.width/2,
                min_y = creatureCollsion.y - creatureCollsion.height/2,
                max_x = creatureCollsion.x + creatureCollsion.width/2,
                max_y = creatureCollsion.y + creatureCollsion.height/2,
            }

            local isColl = global.commonFunc:checkCollision(effect_rect,creature_rect)
            if isColl then
                isCollsion = true
                table.insert(objs,var)
            end
        end
    end
    
    if isCollsion == true then
       local beattack_effect = effect:getOwner():getAttr(ATTR_DEFINE.SKILL_BEATTACK_EFFECT)
       beattack_effect = tonumber(beattack_effect)
--       effect:dispose()
       
        for key, var in pairs(objs) do
            local type = var:getAttr(ATTR_DEFINE.TYPE)
            var:changeActionState(MACHINE_STATE_TYPE.HURT)
            if type == CREATURE_TYPE.BOSS then
                print("attack boss")
                if beattack_effect>0 then
                    local effect = global.effectMgr:createCommonEffect(beattack_effect,var)
                    effect:play()
                    effect:setPosition(0,0)
                end
            else
                if beattack_effect>0 then
                    local effect = global.effectMgr:createCommonEffect(beattack_effect,var)
                    effect:play()
                    effect:setPosition(0,0)
                end   
            end
        end
    end
    objs = nil
    
    if true then
        return
    end
    
    local isCollsion = false
    local objs = {}
	local t = global.objMgr:getAllObjects()
	for key, var in pairs(t) do
        local type = var:getAttr(ATTR_DEFINE.TYPE)
        local actionName = var:getAction()
        local typeEft = effect:getOwner():getAttr(ATTR_DEFINE.TYPE)
        
        local isMonster = false
        if typeEft == CREATURE_TYPE.MONSTER or typeEft == CREATURE_TYPE.BOSS then
            if type == CREATURE_TYPE.MONSTER or type == CREATURE_TYPE.BOSS then
                isMonster = true
            end
        end
        
        local isXianJing = false
        if type == CREATURE_TYPE.XIANJING or typeEft == CREATURE_TYPE.XIANJING then
            isXianJing = true
        end
        
        if type ~= typeEft and isMonster == false and isXianJing == false and actionName ~= CREATURE_ACTION_NAME.DIE then
            
--            local ex,ey = effect:getPosition()
            
            local vx,vy = effect:getAttackCollision():getPosition()
            
--            local vp = cc.p(vx+ex,vy+ey)
            
            local vp = effect:convertToWorldSpace(cc.p(vx,vy))
            local rect = effect:getAttackCollision():getBoundingBox()
            
            local effectCollsion = cc.rect(vp.x,vp.y,rect.width,rect.height)
            
            vx,vy = var:getAttackedCollision():getPosition()
--            vp = cc.p(vx,vy)
            vp = var:convertToWorldSpace(cc.p(vx,vy))
            rect = var:getAttackedCollision():getBoundingBox()
            local creatureCollsion = cc.rect(vp.x,vp.y,rect.width,rect.height)
            
            local effect_rect = {
                x = effectCollsion.x,
                y = effectCollsion.y,
                width = effectCollsion.width,
                height = effectCollsion.height,
                min_x = effectCollsion.x-effectCollsion.width/2,
                min_y = effectCollsion.y - effectCollsion.height/2,
                max_x = effectCollsion.x+effectCollsion.width/2,
                max_y = effectCollsion.y+effectCollsion.height/2,
            }
            
            local creature_rect = {
                x = creatureCollsion.x,
                y = creatureCollsion.y,
                width = creatureCollsion.width,
                height = creatureCollsion.height,
                min_x = creatureCollsion.x - creatureCollsion.width/2,
                min_y = creatureCollsion.y - creatureCollsion.height/2,
                max_x = creatureCollsion.x + creatureCollsion.width/2,
                max_y = creatureCollsion.y + creatureCollsion.height/2,
            }
            
            local isColl = global.commonFunc:checkCollision(effect_rect,creature_rect)
            if isColl then
                isCollsion = true
                table.insert(objs,var)
            end
        end
	end
	
	if isCollsion == true then
       local beattack_effect = effect:getOwner():getAttr(ATTR_DEFINE.SKILL_BEATTACK_EFFECT)
       beattack_effect = tonumber(beattack_effect)
	   effect:dispose()
	   for key, var in pairs(objs) do
	       local type = var:getAttr(ATTR_DEFINE.TYPE)
	       if type == CREATURE_TYPE.BOSS then
	           print("attack boss")
                local hp = var:getHP()
                if hp<=0 then
                    global.objMgr:destroyObject(var:getAttr(ATTR_DEFINE.ID))
                else
                    hp = hp - 20
                    var:setHP(hp)
                    if beattack_effect>0 then
                        local effect = global.effectMgr:createCommonEff(beattack_effect,var)
                        effect:play()
                        effect:setPosition(-136.5,309.3)
                    end
                end
	       else
                local hp = var:getHP()
                if hp<=0 then
                    var:changeActionState(MACHINE_STATE_TYPE.DIE)
                else
                    hp = hp-20
                    var:setHP(hp)
                    if type == CREATURE_TYPE.PLAYER then
                        local vp = math.floor(hp/var:getMaxHp()*100)
                        global.shotMgr:applyFn(GAME_EVENTS.UPDATE_ROLE_HD_VALUE,vp)
                        if vp == 50 then
--                            global.shotMgr:applyFn(GAME_EVENTS.OPEN_BAOYI_EVENT)
                        end
                    end
                    
                    var:changeActionState(MACHINE_STATE_TYPE.HURT)
                    if beattack_effect>0 then
                        local effect = global.effectMgr:createCommonEff(beattack_effect,var)
                        effect:play()
                        effect:setPosition(20,100)
                    end
                end    
	       end
	   end
	end
	objs = nil
end

-------------------------------------------------------------------------------------
--- 玩家攻击(普通攻击，技能攻击 , 添加攻击特效)
function combat_op.handlePlayerAttack(creature)
    
    print("combat_op.handlePlayerAttack")
    local m_owner = creature
    
    local skill_id = m_owner:getAttr(ATTR_DEFINE.SKILLID)
    local configs = global.dataMgr:getConfigDatas("skill_config",skill_id)
    local dir  = m_owner:getDirection()
--    local m_parent = global.sceneMgr:getLayer(LAYER_TYPE.THINGS_LAYER)
    local m_parent = global.sceneMgr:getMapLayer(MAP_TYPE.THINGS_LAYER)
    local skill_type = tonumber(configs.type)
    if skill_type == EFFECT_TYPE.COMMON_EFFECT then
        
    elseif skill_type == EFFECT_TYPE.COMMON_NO_EFFECT then
       
    elseif skill_type == EFFECT_TYPE.SKILL_EFFECT then
        local skill = global.effectMgr:createSkillEffect(skill_id,m_parent,m_owner)
        --skill:setLocalZOrder(creature:getLocalZOrder()-2)
        local vx,vy = m_owner:getPosition()
--        local gpt = m_owner:convertToWorldSpace(cc.p(vx,vy))
        skill:play()
        skill:setPosition(cc.p(vx,vy))
        skill:setDirection(dir)
    elseif skill_type == EFFECT_TYPE.VITRO_EFFECT then
        
    end
    
    if true then
        return
    end
    
--    local m_owner = creature
--    
--    local skill_id = m_owner:getAttr(ATTR_DEFINE.SKILLID)
--    local configs = global.dataMgr:getConfigDatas("skill_config",skill_id)
--    local vitro_effects = configs.vitro_effects
--    
--    local vitro_type = tonumber(configs.vitro_type)
--    local dir  = m_owner:getDirection()
--    local m_parent = global.sceneMgr:getLayer(LAYER_TYPE.THINGS_LAYER)
----    local m_parent = global.sceneMgr:getMapLayer(MAP_TYPE.THINGS_LAYER)
--    
--    local skillid = m_owner:getAttr(ATTR_DEFINE.SKILLID)
--    
--    local skill_type = tonumber(configs.type)
--    
--    if skill_type == EFFECT_TYPE.COMMON_EFFECT then
--        
--    elseif skill_type == EFFECT_TYPE.COMMON_NO_EFFECT then
--        
--    elseif skill_type == EFFECT_TYPE.SKILL_EFFECT then
--        local skill = global.effectMgr:createSkillEffectByID(skillid,m_parent,m_owner)
--        skill:setLocalZOrder(creature:getLocalZOrder()-2)
--        local vx,vy = m_owner:getSprite():getPosition()
--        if dir == DIRECTION.LEFT then
--            vx = -vx
--        end
--
--        local gpt = m_owner:convertToWorldSpace(cc.p(vx,vy))
--        local vx,vy = m_owner:getPosition()
--        skill:play()
--        skill:setPosition(gpt)
--        skill:setDirection(dir)
--    elseif skill_type == EFFECT_TYPE.VITRO_EFFECT then
--        if vitro_type == VITRO_CONSTS_TYPE.YES then
--            if vitro_effects ~= "0" then
--                local vitroF = global.effectMgr:createCommonEffect(vitro_effects,m_parent,m_owner)
--                vitroF:setLocalZOrder(creature:getLocalZOrder()-1)
--                local vx,vy = m_owner:getSprite():getPosition()
--                if dir == DIRECTION.LEFT then
--                    vx = -vx
--                end
--                local gpt = m_owner:convertToWorldSpace(cc.p(vx,vy))
--                local vx,vy = m_owner:getPosition()
--                vitroF:play()
--                vitroF:setPosition(gpt)
--                vitroF:setDirection(dir)
--            end
--
--            local skill = global.effectMgr:createVitroEffect(skillid,m_parent,m_owner)
--            skill:setLocalZOrder(creature:getLocalZOrder()-2)
--            local vx,vy = m_owner:getSprite():getPosition()
--            if dir == DIRECTION.LEFT then
--                vx = -vx
--            end
--
--            local gpt = m_owner:convertToWorldSpace(cc.p(vx,vy))
--            local vx,vy = m_owner:getPosition()
--            skill:play()
--            skill:setPosition(gpt)
--            skill:setDirection(dir)
--        end
--    end
end

--- 怪物攻击(普通攻击，技能攻击 技能攻击特效)
function combat_op.handleMonsterAttack(monster)
    
    print("combat_op.handleMonsterAttack")
    local m_owner = monster

    local skill_id = m_owner:getAttr(ATTR_DEFINE.SKILLID)
    local configs = global.dataMgr:getConfigDatas("skill_config",skill_id)
    local dir  = m_owner:getDirection()
    local m_parent = global.sceneMgr:getMapLayer(MAP_TYPE.THINGS_LAYER)
    local skill_type = tonumber(configs.type)
    if skill_type == EFFECT_TYPE.COMMON_EFFECT then
        
    elseif skill_type == EFFECT_TYPE.COMMON_NO_EFFECT then
        combat_op._handlerMonsterNormalAttack(monster)
    elseif skill_type == EFFECT_TYPE.SKILL_EFFECT then
        local skill = global.effectMgr:createSkillEffect(skill_id,m_parent,m_owner)
        --skill:setLocalZOrder(creature:getLocalZOrder()-2)
        local vx,vy = m_owner:getPosition()
        --        local gpt = m_owner:convertToWorldSpace(cc.p(vx,vy))
        skill:play()
        skill:setPosition(cc.p(vx,vy))
        skill:setDirection(dir)
    elseif skill_type == EFFECT_TYPE.VITRO_EFFECT then
    
    end
end

function combat_op._handlerMonsterNormalAttack(monster)
    local isCollsion = false
    local objs = {}
    local t = global.objMgr:getAllObjects()
    
    for key, var in pairs(t) do
        local type = var:getAttr(ATTR_DEFINE.TYPE)
        local actionName = var:getAction()
--        local typeEft = effect:getOwner():getAttr(ATTR_DEFINE.TYPE)

        local isPlayer = false
        
        if type == CREATURE_TYPE.PLAYER and actionName ~= CREATURE_ACTION_NAME.DIE  then
            local vx,vy = monster:getAttackCollision():getPosition()
            local vp = monster:convertToWorldSpace(cc.p(vx,vy))
            local rect = monster:getAttackCollision():getBoundingBox()
            local effectCollsion = cc.rect(vp.x,vp.y,rect.width,rect.height)
            
            vx,vy = var:getAttackedCollision():getPosition()
            vp = var:convertToWorldSpace(cc.p(vx,vy))
            rect = var:getAttackedCollision():getBoundingBox()
            local creatureCollsion = cc.rect(vp.x,vp.y,rect.width,rect.height)
            
            local effect_rect = {
                x = effectCollsion.x,
                y = effectCollsion.y,
                width = effectCollsion.width,
                height = effectCollsion.height,
                min_x = effectCollsion.x-effectCollsion.width/2,
                min_y = effectCollsion.y - effectCollsion.height/2,
                max_x = effectCollsion.x+effectCollsion.width/2,
                max_y = effectCollsion.y+effectCollsion.height/2,
            }

            local creature_rect = {
                x = creatureCollsion.x,
                y = creatureCollsion.y,
                width = creatureCollsion.width,
                height = creatureCollsion.height,
                min_x = creatureCollsion.x - creatureCollsion.width/2,
                min_y = creatureCollsion.y - creatureCollsion.height/2,
                max_x = creatureCollsion.x + creatureCollsion.width/2,
                max_y = creatureCollsion.y + creatureCollsion.height/2,
            }

            local isColl = global.commonFunc:checkCollision(effect_rect,creature_rect)
            if isColl then
                isCollsion = true
                table.insert(objs,var)
            end
        end
    end

    if isCollsion == true then
        local beattack_effect = monster:getAttr(ATTR_DEFINE.SKILL_BEATTACK_EFFECT)
        beattack_effect = tonumber(beattack_effect)

        for key, var in pairs(objs) do
            local type = var:getAttr(ATTR_DEFINE.TYPE)
            var:changeActionState(MACHINE_STATE_TYPE.HURT)
            if beattack_effect>0 then
                local effect = global.effectMgr:createCommonEffect(beattack_effect,var)
                effect:play()
                effect:setPosition(0,0)
            end
        end
    end
    objs = nil
end

--- boss 攻击（普通攻击，技能攻击 添加特效）
function combat_op.handleBossAttack(boss)
	combat_op.handleMonsterAttack(boss)
end

--function combat_op._handleMonsterNormalAttack(monster)
--	local isCollsion = false
--    local objs = {}
--    local t = global.objMgr:getAllObjects()
--    if global.currentPlayer == nil or global.currentPlayer:getMachine():getCurrentState() == MACHINE_STATE_TYPE.DIE  then
--        print("player is die")
--        return
--    end
--    local player = global.currentPlayer
--    local m_attack_collsion = monster:getAttackCollision():getBoundingBox()
--    local player_beattack_collsion = player:getAttackedCollision():getBoundingBox()
--    local m_dir = monster:getDirection()
--    local p_dir = player:getDirection()
--    local m_pt,p_pt
--    if m_dir == DIRECTION.RIGHT then
--        m_pt = cc.p(m_attack_collsion.x+2*math.abs(m_attack_collsion.x),m_attack_collsion.y)
--    else
--        m_pt = cc.p(m_attack_collsion.x,m_attack_collsion.y)
--    end
--    if p_dir == DIRECTION.LEFT then
--    end
--    p_pt = cc.p(player_beattack_collsion.x,player_beattack_collsion.y)
--    
--    local m_vp = monster:convertToWorldSpace(m_pt)
--    local p_vp = player:convertToWorldSpace(p_pt)
--    local m_rect = cc.rect(m_vp.x,m_vp.y,m_attack_collsion.width,m_attack_collsion.height)
--    local p_rect = cc.rect(p_vp.x,p_vp.y,player_beattack_collsion.width,player_beattack_collsion.height)
--    local m_in_rect = {
--        x = m_rect.x,
--        y = m_rect.y,
--        width = m_rect.width,
--        height = m_rect.height,
--        min_x = m_rect.x-m_rect.width/2,
--        min_y = m_rect.y - m_rect.height/2,
--        max_x = m_rect.x+m_rect.width/2,
--        max_y = m_rect.y+m_rect.height/2,
--    }
--
--    local p_in_rect = {
--        x = p_rect.x,
--        y = p_rect.y,
--        width = p_rect.width,
--        height = p_rect.height,
--        min_x = p_rect.x - p_rect.width/2,
--        min_y = p_rect.y - p_rect.height/2,
--        max_x = p_rect.x + p_rect.width/2,
--        max_y = p_rect.y + p_rect.height/2,
--    }
--    
--    local isColl = global.commonFunc:checkCollision(m_in_rect,p_in_rect)
--    if isColl then
--        local hp = player:getHP()
--        if hp<=0 then
--            player:changeActionState(MACHINE_STATE_TYPE.DIE)
--        else
--            hp = hp-20
--            player:setHP(hp)
--            player:changeActionState(MACHINE_STATE_TYPE.HURT)
--        end
--    end
--end
