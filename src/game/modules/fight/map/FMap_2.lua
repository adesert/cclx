
local FMap_2 = class("FMap_2",require("game.base.BaseLayer"))

function FMap_2:ctor(id)
    self.m_id = id
    self.m_data = nil
    self.super.ctor(self)
end

function FMap_2:_overrideInit()
    self:_init()
    self:_initdata()
    self:_initCreatures()
end
function FMap_2:_init()
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

    local sp = cc.Sprite:create("map/map_2/map_2_yuanjing.png")
    sp:setAnchorPoint(cc.p(0,0))
    self.bg_layer:addChild(sp)
    sp:setPosition(cc.p(0,230))

    self.m_w = sp:getContentSize().width
    self.m_h = sp:getContentSize().height

    sp = cc.Sprite:create("map/map_2/map_2_dimian.png")
    sp:setAnchorPoint(cc.p(0,0))
    self.middle_layer:addChild(sp)
    sp:setPosition(cc.p(0,0))
    
    sp = cc.Sprite:create("map/map_2/map_2_qianjing.png")
    sp:setAnchorPoint(cc.p(0,0))
    self.near_layer:addChild(sp)
    sp:setPosition(cc.p(192,0))
    
    
--
    self.mapMoveSpace = cc.rect(0,23,1700,190)
end

function FMap_2:_initCreatures()
    self.player = global.objMgr:createCreatureByProto("1_1",self.creature_layer)
    self.player:setPosition(center_x,200)
    
    self:_testSpine()

    local ts = {{363.2,141.2},{372.8,69.2},{525.2,102.8},{644.0,98.0},{956.0,172.4},{1088.0,98.0},{1242.8,120.8},{1335.2,112.4}
        ,{1436.0,150.8},{1245.2,70.4},{1480.4,68.0},{981.2,100.4},{812.0,142.4}}
    
    local monsters = {1,2,3,4,6,7,8,9,10,11,12,13,14};
    
    for i=1,#ts do
        local s = "10_"..monsters[i]
        local p =  global.objMgr:createCreatureByProto(s,self.creature_layer)
        p:setPosition(ts[i][1],ts[i][2])
    end
end

function FMap_2:_testSpine()
--    local skeletonNode = sp.SkeletonAnimation:create("spine/spineboy.json", "spine/spineboy.atlas", 0.6)
    local skeletonNode = sp.SkeletonAnimation:create("spine2/ceshi.json", "spine2/ceshi.atlas")
--    local skeletonNode = sp.SkeletonAnimation:create("spine2/nvzhu1.json", "spine2/nvzhu1.atlas")
    
    skeletonNode:registerSpineEventHandler(function (event)
        print(string.format("[spine] %d start: %s", 
            event.trackIndex,
            event.animation))
    end, sp.EventType.ANIMATION_START)

    skeletonNode:registerSpineEventHandler(function (event)
        print(string.format("[spine] %d end:", 
            event.trackIndex))
    end, sp.EventType.ANIMATION_END)

    skeletonNode:registerSpineEventHandler(function (event)
        print(string.format("[spine] %d complete: %d", 
            event.trackIndex, 
            event.loopCount))
    end, sp.EventType.ANIMATION_COMPLETE)

    skeletonNode:registerSpineEventHandler(function (event)
        print(string.format("[spine] %d event: %s, %d, %f, %s", 
            event.trackIndex,
            event.eventData.name,
            event.eventData.intValue,
            event.eventData.floatValue,
            event.eventData.stringValue))
    end, sp.EventType.ANIMATION_EVENT)

--    skeletonNode:setMix("walk", "jump", 0.2)
--    skeletonNode:setMix("jump", "run", 0.2)
--    skeletonNode:setAnimation(0, "stand01",true)

--    skeletonNode:addAnimation(0, "jump", false, 3)
--    skeletonNode:addAnimation(0, "run", true)

    --
    skeletonNode:setAnimation(0, "run",true)

    local windowSize = cc.Director:getInstance():getWinSize()
--    skeletonNode:setPosition(cc.p(windowSize.width / 2, 20))
    skeletonNode:setPosition(center_x,200)
    self:addChild(skeletonNode)
    
    skeletonNode:setScaleX(-1)
    
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(function (touch, event)
--        if not skeletonNode:getDebugBonesEnabled() then
--            skeletonNode:setDebugBonesEnabled(true)
--        elseif skeletonNode:getTimeScale() == 1 then
--            skeletonNode:setTimeScale(0.3)
--        else
--            skeletonNode:setTimeScale(1)
--            skeletonNode:setDebugBonesEnabled(false)
--        end
        
        local acs = {"stand01","run","attack01","behit"}
        local rid = math.random(1,4)
        
--        skeletonNode:clearTracks()
        skeletonNode:setAnimation(0, acs[rid], true)

        return true
    end,cc.Handler.EVENT_TOUCH_BEGAN )

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
    
--    local sp = cc.Sprite:create("spine2/33333.png")
--    sp:setAnchorPoint(cc.p(0.5,0))
--    sp:setPosition(center_x-100,200)
--    self:addChild(sp)
    
--    skeletonNode:setScale(0.25)
--    skeletonNode:setScale(0.25)
end

function FMap_2:_initdata()

end

function FMap_2:handle()

end

function FMap_2:updateDir(dir,moveDir,actionName)
    self:_changePlayerDir(dir,moveDir,actionName)
end

function FMap_2:updateDirEnd(dir,moveDir,actionName)
    print(dir,moveDir,actionName)
    self:_changePlayerDir(dir,moveDir,actionName)
    self:checkCollsionPlayer()
end

function FMap_2:_changePlayerDir(dir,moveDir,actionName)

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

function FMap_2:updateMapMove()
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

function FMap_2:checkCollsionPlayer()
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

function FMap_2:clear()
    global.effectMgr:clearAllEffect()
    global.objMgr:clearObjects()
end

return FMap_2