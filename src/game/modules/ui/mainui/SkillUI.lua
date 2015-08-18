
local SkillUI = class("SkillUI",require("game.base.BaseLayer"))

function SkillUI:ctor()
	self.super.ctor(self)
end

function SkillUI:_overrideInit()
    local ccbname = "skill_ui"
    self.ccb = self:loadCCB(ccbname)
    self.ccb:setCallFunc("xiexia_func",handler(self,self._xieZaifunc))
    self.ccb:setCallFunc("zhuangbei_func",handler(self,self._zhuangbeiFunc))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    --    self.ccb:setScale(0.2)
    --    local s = cc.ScaleTo:create(0.5,1)
    --    local action1 = cc.EaseBackOut:create(s)
    --    self.ccb:runAction(action1)

    self:_init()
end

function SkillUI:_init()
    
    global.mainUIMgr:registerFn(GAME_EVENTS.UPDATE_SKILL_PANNEL_DATA,handler(self,self._updateDatas))
    
    local pos = {{88.5,88.9},{190.2,88.9},{292.0,88.9},{393.8,88.9},{495.5,88.9},{597.3,88.9},{699.0,88.9},{800.8,88.9}}
    -- state (1 开启，2，等级激活，3 购买激活）
    local data = {{type =0,id = 1001,state = 1,lv = 1,name = "test1",desc = "hello 1",money = 300},
        {type =0,id = 1002,state = 1,lv = 1,name = "test2",desc = "hello 2",money = 300},
                    {type =2,id = 1003,state = 3,lv = 1,name = "test3",desc = "hello 2",money = 300},
                    {type =2,id = 1003,state = 3,lv = 1,name = "test4",desc = "hello 3",money = 300}}
                    
    for i=1,#data do 
        local cell = require("game.modules.ui.mainui.item.SkillItem").new(data[i])
        cell:setPosition(pos[i][1],pos[i][2])
        self.ccb:addChild(cell)
    end
    
    pos = {{969.0,87.7},{1074.6,87.7}}
    for i=1,2 do
        local cell = require("game.modules.ui.mainui.item.SkillItem").new()
        cell:setPosition(pos[i][1],pos[i][2])
        self.ccb:addChild(cell)
        cell:clearCells()
    end
end

function SkillUI:_xieZaifunc()
end

function SkillUI:_zhuangbeiFunc()
end

function SkillUI:_updateDatas(data)
	self.ccb["tf_lv"]:setString(data["lv"].."")
	self.ccb["tf_name"]:setString(data["name"].."")
	self.ccb["tf_desc"]:setString(data["desc"].."")
end

function SkillUI:clear()
    global.mainUIMgr:unRegisterFn(GAME_EVENTS.UPDATE_SKILL_PANNEL_DATA)
end

return SkillUI