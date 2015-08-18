
local FMap_1 = class("FMap_1",require("game.base.BaseLayer"))

function FMap_1:ctor(id)
    self.m_id = id
    self.m_data = nil
	self.super.ctor(self)
end

function FMap_1:_overrideInit()
    self:_init()
    self:_initdata()
    self:_initCreatures()
end

function FMap_1:_init()
    self.bg_layer = cc.Layer:create()
    self:addChild(self.bg_layer)

    self.cloudLayer = cc.Layer:create()
    self:addChild(self.cloudLayer)

    self.middle_layer = cc.Layer:create()
    self:addChild(self.middle_layer)

    self.creature_layer = cc.Layer:create()
    self:addChild(self.creature_layer)

    self.near_layer = cc.Layer:create()
    self:addChild(self.near_layer)

    local sp = cc.Sprite:create("map/huajie_scene/huajie_scene_1.png")
    sp:setAnchorPoint(cc.p(0,0))
    self.bg_layer:addChild(sp)
    sp:setPosition(cc.p(0,0))

    self.m_w = sp:getContentSize().width
    self.m_h = sp:getContentSize().height

    local clouds = cc.Sprite:create("map/huajie_scene/huajie_scene_4.png")
    clouds:setAnchorPoint(cc.p(0,0))
    self.cloudLayer:addChild(clouds)
    clouds:setPosition(cc.p(1900,364))

    local a1 = cc.MoveTo:create(8,cc.p(-1484,364))
    local a2 = cc.CallFunc:create(function() 
        clouds:setPosition(cc.p(1900,364))
    end)
    clouds:runAction(cc.RepeatForever:create(cc.Sequence:create(a1,a2)))

    sp = cc.Sprite:create("map/huajie_scene/huajie_scene_5.png")
    sp:setAnchorPoint(cc.p(0,0))
    self.middle_layer:addChild(sp)
    sp:setPosition(cc.p(0,0))

    sp = cc.Sprite:create("map/huajie_scene/huajie_scene_2.png")
    sp:setAnchorPoint(cc.p(0,0))
    self.near_layer:addChild(sp)
    sp:setPosition(cc.p(0,99))

    sp = cc.Sprite:create("map/huajie_scene/huajie_scene_3.png")
    sp:setAnchorPoint(cc.p(0,0))
    self.near_layer:addChild(sp)
    sp:setPosition(cc.p(0,0))

    self.mapMoveSpace = cc.rect(0,125,1900,170)
end

function FMap_1:_initCreatures()
--    local chuansongmen = global.effectMgr:createSkillEffect("17",self.creature_layer,nil)
--    chuansongmen:play()
--    chuansongmen:setPosition(193,180)
--    chuansongmen:setDefineData(1)
--
--    local chuansongmen = global.effectMgr:createSkillEffect("17",self.creature_layer,nil)
--    chuansongmen:play()
--    chuansongmen:setPosition(1727,180)
--    chuansongmen:setDefineData(2)

    self.player = global.objMgr:createCreatureByProto("1_1",self.creature_layer)
    self.player:setPosition(center_x,200)
end

function FMap_1:_initdata()

end

function FMap_1:handle()

end

function FMap_1:updateDir(dir,moveDir,actionName)
    self:_changePlayerDir(dir,moveDir,actionName)
end

function FMap_1:updateDirEnd(dir,moveDir,actionName)
    print(dir,moveDir,actionName)
    self:_changePlayerDir(dir,moveDir,actionName)
    self:checkCollsionPlayer()
end

function FMap_1:_changePlayerDir(dir,moveDir,actionName)

    if not self.player then
        return
    end

    local cState =  self.player:getMachine():getCurrentState()
    if cState == MACHINE_STATE_TYPE.DIE then
        return
    end
    if dir>0 then
        self.player:setDirection(dir)
    end
    local isStand = false
    if cState ~=actionName then
        if actionName == MACHINE_STATE_TYPE.MOVE then
            self.player:changeActionState(actionName)
        elseif actionName == MACHINE_STATE_TYPE.STAND then
            self.player:changeActionState(actionName)
            isStand = true
        end
    end

    if isStand == true then 
        return
    end
    local speed = self.player:getAttr(ATTR_DEFINE.SPEED)

    local vx,vy = self.player:getPosition()

    local directionDir = self.player:getDirection()

    if moveDir == CREATURE_MOVE_DIR.RIGHT then
        vx = vx+speed   
    elseif moveDir == CREATURE_MOVE_DIR.LEFT then
        vx = vx-speed
    elseif moveDir == CREATURE_MOVE_DIR.UP then
        vy = vy+speed
    elseif moveDir == CREATURE_MOVE_DIR.DOWN then
        vy = vy-speed
    end
    local rect = self.mapMoveSpace
    local inRectSign = global.commonFunc:checkPointInRect(cc.p(vx,vy),rect)
    if inRectSign == true then
        self.player:setPosition(cc.p(vx,vy))
    else
        if vx > rect.width+rect.x or vx < rect.x then
            return
        end

        if directionDir == DIRECTION.LEFT  then
            vx = vx-speed   
        elseif directionDir == DIRECTION.RIGHT then
            vx = vx+speed
        end

        self.player:setPositionX(vx)
    end

    self:updateMapMove()
end

function FMap_1:updateMapMove()
    local vx,vy = self:getPosition()
    local mapW =  self.m_w
    local mapH = self.m_h
    local player = self.player
    local dir = player:getDirection()
    local moveSpeed = player:getAttr(ATTR_DEFINE.SPEED)
    local px,py = player:getPosition()
    local xd = px + vx
    local gxdx = xd - center_x
    local GP = 10
    local SP = moveSpeed
    if dir == DIRECTION.LEFT then
        if gxdx <= -GP then
            vx = vx + SP
            if vx<=0 then
                self:setPositionX(vx)
            end
        end
    elseif dir == DIRECTION.RIGHT then
        if gxdx >= GP then
            vx = vx - SP
            if vx + mapW >= define_right then
                self:setPositionX(vx)
            end
        end
    end
end

function FMap_1:checkCollsionPlayer()
    local isCollsion = false
    local objs = {}

    local t = global.effectMgr:getAllObjects()
    for key, var in pairs(t) do
        local type = var:getEffectType()
        if type == EFFECT_TYPE.CHUANSONGMEN_EFFECT then
            local vx,vy = var:getAttackCollision():getPosition()
            local vp = var:convertToWorldSpace(cc.p(vx,vy))
            local rect = var:getAttackCollision():getBoundingBox()
            local effectCollsion = cc.rect(vp.x,vp.y,rect.width,rect.height)

            vx,vy = self.player:getAttackedCollision():getPosition()
            vp = self.player:convertToWorldSpace(cc.p(vx,vy))
            rect = self.player:getAttackedCollision():getBoundingBox()
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
                print("--------->>>",var:getDefineData())
                local id = var:getDefineData()
                break
            end
        end
    end
end

function FMap_1:clear()
    global.effectMgr:clearAllEffect()
    global.objMgr:clearObjects()
end

return FMap_1