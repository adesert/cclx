
local CreateRoleWnd = class("CreateRoleWnd",require("game.base.BaseLayer"))

function CreateRoleWnd:ctor()
	self.super.ctor(self)
end

function CreateRoleWnd:_overrideInit()
    self.namex = require("game.modules.login.Names").new()
    self.ccb = self:loadCCB("create_role")
    self.ccb:setCallFunc("create_role_func",handler(self,self.create_role_func))
    self.ccb:setCallFunc("enter_game_func",handler(self,self.enter_game_func))
    self.ccb:setCallFunc("deleted_role_func",handler(self,self.deleted_role_func))
    self.ccb:setCallFunc("random_func",handler(self,self.random_func))
    
    self.ccb:initCCB()
    self:addChild(self.ccb)

    self:_init()
    self:_initData()
end

function CreateRoleWnd:_init()
    self.img_role_1 = self.ccb["img_role_1"]
    self.img_role_2 = self.ccb["img_role_2"]
    
    self.img_randmon = self.ccb["img_randmon"]
    
    self.img_role_1.id = 1;
    self.img_role_2.id = 2;
    self.img_role_1.state = true;
    self.img_role_2.state = false
    
    node_touchEvent(self.img_role_1,handler(self,self._begainFunc),nil,nil,nil)
    node_touchEvent(self.img_role_2,handler(self,self._begainFunc),nil,nil,nil)
    
    local s = self.img_role_1:getContentSize()
    self.img_role_1:setSpriteFrame(cc.SpriteFrame:create("imgs/role_1_1.png",s))
    
    local s = self.img_role_2:getContentSize()
    self.img_role_2:setSpriteFrame(cc.SpriteFrame:create("imgs/role_2_2.png",s))
    
    local sp = ccui.Scale9Sprite:create("scale_9.png")
    sp:setOpacity(0)
    self.eitor = ccui.EditBox:create(cc.size(140,30),sp)
    self.eitor:setPosition(120,46)
    self.img_randmon:addChild(self.eitor)
    self.eitor:setFontSize(25)
    self.eitor:setFontColor(cc.c3b(255,255,255))
    self.eitor:setMaxLength(5)
    self.eitor:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
    
--    self.eitor:registerScriptEditBoxHandler(handler(self,self._eitorFunc))
end

function CreateRoleWnd:_eitorFunc(strEventName,pSender)
    local edit = pSender
    local strFmt 
    if strEventName == "began" then
    elseif strEventName == "ended" then
    elseif strEventName == "return" then
    elseif strEventName == "changed" then
        strFmt = string.format("editBox %p TextChanged, text: %s ", edit, edit:getText())
    end
end

function CreateRoleWnd:_initData()
    self.role_info = {}
    local r = global.localMgr:getDataByKey(LOCAL_DATA_KEY.ROLE_INFO)
    for key, var in pairs(r) do
    	self.role_info[key] = var
    end
    
    self.role_id = 1
    
    self:random_func()
end

function CreateRoleWnd:create_role_func()
    local str = self.eitor:getText()
    if str == "" then
        global.flyWordMgr:show("名字不能为空")
        return
    elseif self.namex:getIsNameUsed(str) <0 then
        global.flyWordMgr:show("名字中包含了敏感词，请重新输入")
        --        self.eitor:setText("")
        return
    end
    
    local info = global.localMgr:getDataByKey(LOCAL_DATA_KEY.ROLE_INFO)
    
    for key, var in pairs(info) do
    	if var.id == self.role_id then
    		var.roleid = self.role_id
    		var.rolename = str
    		break
    	end
    end
    
    global.flyWordMgr:show("创建成功")
    global.localMgr:setDataByKey(LOCAL_DATA_KEY.ROLE_INFO,info)
end
function CreateRoleWnd:enter_game_func()
    self:deleted_role_func()
end

function CreateRoleWnd:deleted_role_func()
    local roleinfo = global.localMgr:getDataByKey(LOCAL_DATA_KEY.ROLE_INFO)
    local isCreate = true
    for key, var in pairs(roleinfo) do
        if var.roleid>0 then
            isCreate = false
            break
        end
    end
    if isCreate == true then
    	global.flyWordMgr:show("请先创建一个角色！")
    	return
    end
    global.popWndMgr:close(KONG_WNDS.CREATE_ROLE_WND)
    global.popWndMgr:open(KONG_WNDS.SELECTE_ROLE_WND)
end

function CreateRoleWnd:random_func()
    local str = self.namex:getRandomName()
    self.eitor:setText(str)
end

function CreateRoleWnd:_begainFunc(touch,event)
    local target = event:getCurrentTarget()
    local locationInNode = target:convertToNodeSpace(touch:getLocation())
    local s = target:getContentSize()
    local rect = cc.rect(0, 0, s.width, s.height)
    
    if cc.rectContainsPoint(rect, locationInNode) then
        local id = target.id;
        local state = target.state
--        target:setOpacity(180)

        if id == 1 then
            if state == false then
                target:setOpacity(100)
                self.img_role_1:setSpriteFrame(cc.SpriteFrame:create("imgs/role_1_1.png",s))
                local ss = self.img_role_2:getContentSize()
                self.img_role_2:setSpriteFrame(cc.SpriteFrame:create("imgs/role_2_2.png",ss))
                self.img_role_1.state = true
                self.img_role_2.state = false
                self.role_info.roleid = 1
                self:_setSpOp(self.img_role_1)
                self:_setSpOp(self.img_role_2)
                self.role_id = 1
            end
        else
            if state == false then
                target:setOpacity(100)
                local ss = self.img_role_2:getContentSize()
                self.img_role_1:setSpriteFrame(cc.SpriteFrame:create("imgs/role_1_2.png",ss))
                self.img_role_2:setSpriteFrame(cc.SpriteFrame:create("imgs/role_2_1.png",s))
                self.img_role_1.state = false
                self.img_role_2.state = true
                self.role_info.roleid = 2
                self:_setSpOp(self.img_role_1)
                self:_setSpOp(self.img_role_2)
                self.role_id = 2
            end
        end
        return false
    end
    return false
end

function CreateRoleWnd:_setSpOp(sp)
    sp:runAction(cc.FadeIn:create(0.5))
end

function CreateRoleWnd:_randomNameFunc()
	
end

function CreateRoleWnd:clear()
    
end

return CreateRoleWnd