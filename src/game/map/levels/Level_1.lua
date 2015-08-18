
local Level_1 = class("Level_1",require("game.map.levels.ILevel"))

function Level_1:ctor(id)
	self.super.ctor(self,id)
end

function Level_1:_overrideInit()
    self.wave_list_1 = {}
    self.wave_list_2 = {}
    self.boss_list = {}
    
    self.timerID = 0
	self.timerHandler = SCHE_MGR.scheduleGlobal(handler(self,self._updateTimer),1);
end

function Level_1:_updateTimer()
    self.timerID = self.timerID + 1
end

function Level_1:_overrideParseMapGroup()
    self:_initParseMapData()
end

function Level_1:_initParseMapData()
    local mapData = self:getMapData()
    local zhangaiwu_list = mapData["zhangaiwu_lists"]
    if zhangaiwu_list ~= "0" then
        for key, var in pairs(zhangaiwu_list) do
            local wave_config = global.dataMgr:getConfigDatas("wave_config",var)
            local wave = wave_config["wave_1"]
            for k,v in pairs(wave) do
            	local id = v[1]
            	local vx = v[2]
            	local vy = v[3]
                local xianjing = global.objMgr:createCreatureByProto(id)
                xianjing:setPosition(vx,vy)
            end
        end
    end
    
    local born_pos = mapData["born_pos"]
    local fx = born_pos[1]
    local fy = born_pos[2]
    
    local bornEft = global.effectMgr:createCommonEffect("11")
    global.sceneMgr:getMapLayer(MAP_TYPE.UP_EFF_LAYER):addChild(bornEft)
    bornEft:setPosition(fx,fy)
    
    local player = global.objMgr:createCreatureByProto("1_1")
    player:setPosition(fx,fy)
    global.currentPlayer = player
    
    self.wave_list_1 = mapData["wave_list_1"]
    self.wave_list_2 = mapData["wave_list_2"]
    self.boss_list = mapData["boss"]
end

function Level_1:handler()
--- 怪物的波数和锁屏 ， 还有几波插入锁屏， 在那个位置出现怪物
--    if true then
--        return
--    end
    if not global.currentPlayer then
        return
    end
    
    if self.wave_list_1 and self.wave_list_1 ~= "0" then
        for key, var in pairs(self.wave_list_1) do
            print(key,var)
            if var then
                local wave_config = global.dataMgr:getConfigDatas("wave_config",var)
                local conditions = wave_config["conditions"]
                local wave = wave_config["wave_1"]
                if conditions == "0" then
                    for k,v in pairs(wave) do
                        local id = v[1]
                        local vx = v[2]
                        local vy = v[3]
                        local c = global.objMgr:createCreatureByProto(id)
                        c:setPosition(vx,vy)
                        local bornEft = global.effectMgr:createCommonEffect("11")
                        global.sceneMgr:getMapLayer(MAP_TYPE.THINGS_LAYER):addChild(bornEft)
                        bornEft:setPosition(vx,vy)
                    end
                else
                    local type = tonumber(conditions[1])
                    if type == MONSTER_CONDITIONS.TIME then
                        local time = tonumber(conditions[2])
                        if time >=self.timerID then
                            self:_addCreatureByID(wave)
                            self.wave_list_1[key] = nil
                        end
                    elseif type == MONSTER_CONDITIONS.HP then
                        local hp = tonumber(conditions[2])
                        if hp>=self:_getObjMonsters() then
                            self:_addCreatureByID(wave)
                            self.wave_list_1[key] = nil
                        end
                    elseif type == MONSTER_CONDITIONS.SPACE then
                        local vx = tonumber(conditions[2])
                        local vy = tonumber(conditions[3])
                        local px,py = global.currentPlayer:getPosition()
                        local len = global.commonFunc:twoPointDistance(cc.p(vx,vy),cc.p(px,py))
                        if len<=40*40 then
                            self:_addCreatureByID(wave)
                            self.wave_list_1[key] = nil
                        end
                    end
                end                
            end
        end
    end
    
--    if self.wave_list_2 and self.wave_list_2 ~= "0" then
--        for key, var in pairs(self.wave_list_2) do
--            print(key,var)
--            if var then
--                local wave_config = global.dataMgr:getConfigDatas("wave_config",var)
--                local conditions = wave_config["conditions"]
--                local wave = wave_config["wave_1"]
--                if conditions == "0" then
--                    for k,v in pairs(wave) do
--                        local id = v[1]
--                        local vx = v[2]
--                        local vy = v[3]
--                        local c = global.objMgr:createCreatureByProto(id)
--                        c:setPosition(vx,vy)
--                    end
--                else
--                    local type = tonumber(conditions[1])
--                    if type == MONSTER_CONDITIONS.TIME then
--                        local time = tonumber(conditions[2])
--                        if time >=self.timerID then
--                            self:_addCreatureByID(wave)
--                            self.wave_list_2[key] = nil
--                        end
--                    elseif type == MONSTER_CONDITIONS.HP then
--                        local hp = tonumber(conditions[2])
--                        if hp>=self:_getObjMonsters() then
--                            self:_addCreatureByID(wave)
--                            self.wave_list_2[key] = nil
--                        end
--                    elseif type == MONSTER_CONDITIONS.SPACE then
--                        local vx = tonumber(conditions[2])
--                        local vy = tonumber(conditions[3])
--                        local px,py = global.currentPlayer:getPosition()
--                        local len = global.commonFunc:twoPointDistance(cc.p(vx,vy),cc.p(px,py))
--                        if len<=40*40 then
--                            self:_addCreatureByID(wave)
--                            self.wave_list_2[key] = nil
--                        end
--                    end
--                end                
--            end
--        end
--    end
    
    if self.boss_list and self.boss_list ~= "0" then
        for key, var in pairs(self.boss_list) do
            if var then
                local wave_config = global.dataMgr:getConfigDatas("wave_config",var)
                local conditions = wave_config["conditions"]
                local wave = wave_config["wave_1"]
                if conditions == "0" then
                    for k,v in pairs(wave) do
                        local id = v[1]
                        local vx = v[2]
                        local vy = v[3]
                        local c = global.objMgr:createCreatureByProto(id)
                        c:setPosition(vx,vy)
                    end
                else
                    local type = tonumber(conditions[1])
                    if type == MONSTER_CONDITIONS.TIME then
                        local time = tonumber(conditions[2])
                        if time >=self.timerID then
                            self:_addCreatureByID(wave)
                            self.boss_list[key] = nil
                        end
                    elseif type == MONSTER_CONDITIONS.HP then
                        local hp = tonumber(conditions[2])
                        if hp>=self:_getObjMonsters() then
                            self:_addCreatureByID(wave)
                            self.boss_list[key] = nil
                        end
                    elseif type == MONSTER_CONDITIONS.SPACE then
                        local vx = tonumber(conditions[2])
                        local vy = tonumber(conditions[3])
                        local px,py = global.currentPlayer:getPosition()
                        local len = global.commonFunc:twoPointDistance(cc.p(vx,vy),cc.p(px,py))
                        if len<=40*40 then
                            self:_addCreatureByID(wave)
                            self.boss_list[key] = nil
                        end
                    end
                end                
            end
        end
    end
end

function Level_1:_addCreatureByID(wave)
    for k,v in pairs(wave) do
        local id = v[1]
        local vx = v[2]
        local vy = v[3]
        local c = global.objMgr:createCreatureByProto(id)
        c:setPosition(vx,vy)
        
        local bornEft = global.effectMgr:createCommonEffect("11")
        global.sceneMgr:getMapLayer(MAP_TYPE.UP_EFF_LAYER):addChild(bornEft)
        bornEft:setPosition(vx,vy)
    end
end

function Level_1:_getObjMonsters()
	local obj = global.objMgr:getAllObjects()
	local monsters = {}
	local hpx = 0
	local maxHp = 0
	local hp = 0
	for key, var in pairs(obj) do
        local type = var:getAttr(ATTR_DEFINE.TYPE)
        if type == CREATURE_TYPE.MONSTER then
            monsters[key] = var
            hpx = var:getMaxHp()
            maxHp = maxHp+hpx
            hp = hp+var:getHP()
        end
	end
	if hp == 0 or maxHp == 0 then
	   return 0
	end
	return hp/maxHp*100
end

function Level_1:clear()
    if global.currentPlayer then
        global.objMgr:destroyObject(global.currentPlayer:getAttr(ATTR_DEFINE.ID))
        global.currentPlayer = nil
    end
    if self.timerHandler then
        SCHE_MGR.unscheduleGlobal(self.timerHandler)
        self.timerHandler = nil
    end
    global.objMgr:clearObjects()
    global.effectMgr:clearAllEffect()
end

return Level_1