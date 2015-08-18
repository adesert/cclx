
local SelectRoleWnd = class("SelectRoleWnd",require("game.base.BaseLayer"))

function SelectRoleWnd:ctor()
	self.super.ctor(self)
end

function SelectRoleWnd:_overrideInit()
    self.ccb = self:loadCCB("select_role")
    self.ccb:setCallFunc("back_func",handler(self,self.back_func))
    self.ccb:setCallFunc("deleted_role_func",handler(self,self.deleted_role_func))
    self.ccb:setCallFunc("enter_game_func",handler(self,self.enter_game_func))
    
    self.ccb:initCCB()
    self:addChild(self.ccb)

    self:_init()
    self:_initDatas()
end

function SelectRoleWnd:_init()
    self.xuanzhuan_left = self.ccb["xuanzhuan_left"]
    self.xuanzhuan_right = self.ccb["xuanzhuan_right"]
    self.img_role_left = self.ccb["img_role_left"]
    self.img_role_right = self.ccb["img_role_right"]
    
    self.img_name_left = self.ccb["img_name_leftx"]
--    self.img_role_name_left = self.ccb["img_role_name_left"]
    
    self.img_name_right = self.ccb["img_name_rightx"]
--    self.img_role_name_right=self.ccb["img_role_name_right"]
    
    self.role_layer_1 = self.ccb["role_layer_1"]
    self.role_layer_2 = self.ccb["role_layer_2"]
    
    self.img_name_left:setVisible(false)
    self.img_name_right:setVisible(false)
end

function SelectRoleWnd:_initDatas()
    self.roleinfo = global.localMgr:getDataByKey(LOCAL_DATA_KEY.ROLE_INFO)
    local role = nil
    for key, var in pairs(self.roleinfo) do
    	if var.id==1 then
    	   if var.roleid >0 then
                self.img_name_left:setVisible(true)
                role = cc.Sprite:create("imgs/role_big_1.png")
                role:setAnchorPoint(cc.p(0,0))
                role:setPosition(251.0,157.5)
                self.role_layer_1:addChild(role)
                role.id = 1
                role:setTag(100)
                node_touchEvent(role,handler(self,self._touchBegan),nil,nil,nil)
           else
                role = cc.Sprite:create("imgs/role_shadow.png")
                role:setAnchorPoint(cc.p(0,0))
                role:setPosition(251.0,157.5)
                self.role_layer_1:addChild(role)
    	   end
        elseif var.id==2 then
            if var.roleid>0 then
                self.img_name_right:setVisible(true)
                role = cc.Sprite:create("imgs/role_big_1.png")
                role:setAnchorPoint(cc.p(0,0))
                role:setPosition(774.0,157.5)
                self.role_layer_2:addChild(role)
                role.id = 2
                role:setTag(100)
                node_touchEvent(role,handler(self,self._touchBegan),nil,nil,nil)
            else
                role = cc.Sprite:create("imgs/role_shadow.png")
                role:setAnchorPoint(cc.p(0,0))
                role:setPosition(774.0,157.5)
                self.role_layer_2:addChild(role)
            end            
    	end
    end
    
    self.selectRole = 0
    
    self.selectRoleSp = nil
    
    for key, var in pairs(self.roleinfo) do
    	if var.roleid>0 then
    		self.selectRole = var.id
    		break
    	end
    end
    
    self:_selectRoleFunc()
end

function SelectRoleWnd:_touchBegan(touch,event)
	local target = event:getCurrentTarget()
    local locationInNode = target:convertToNodeSpace(touch:getLocation())
    local s = target:getContentSize()
    local rect = cc.rect(0, 0, s.width, s.height)
    
    if cc.rectContainsPoint(rect, locationInNode) then
        local id = target.id;
        self.selectRole = id
        self:_selectRoleFunc()
        return false
     end
     return false
end


function SelectRoleWnd:_selectRoleFunc()
--    if self.selectRole ==1  then
--        self.xuanzhuan_left:runAction(cc.RepeatForever:create(cc.RotateBy:create(0.25,20)))
--	end
    print(self.selectRole)
    
    if self.selectRoleSp then
    	self.selectRoleSp:setPositionY(0)
    end
    self.selectRoleSp = nil
    
    if self.selectRole == 1  then
    	self.role_layer_1:setPositionY(15)
    	self.selectRoleSp = self.role_layer_1
    elseif self.selectRole == 2 then
        self.role_layer_2:setPositionY(15)
        self.selectRoleSp = self.role_layer_2
    end
end

function SelectRoleWnd:back_func()
    global.popWndMgr:close(KONG_WNDS.SELECTE_ROLE_WND)
    global.popWndMgr:open(KONG_WNDS.CREATE_ROLE_WND)
end
function SelectRoleWnd:deleted_role_func()
    if self.selectRole == 0 then
        global.flyWordMgr:show("请先选择角色")
        return
    end
    
    local info = global.localMgr:getDataByKey(LOCAL_DATA_KEY.ROLE_INFO)
    for key, var in pairs(info) do
        if var.id == self.selectRole then
            var.roleid = 0
    		break
    	end
    end
    self.selectRoleSp:setPositionY(0)
    local sp = self.selectRoleSp:getChildByTag(100)
    sp:removeFromParent()
    
    local role = nil
    if self.selectRole == 1 then
        role = cc.Sprite:create("imgs/role_shadow.png")
        role:setAnchorPoint(cc.p(0,0))
        role:setPosition(251.0,157.5)
        self.role_layer_1:addChild(role)
        self.img_name_left:setVisible(false)
    elseif self.selectRole == 2 then
        role = cc.Sprite:create("imgs/role_shadow.png")
        role:setAnchorPoint(cc.p(0,0))
        role:setPosition(774.0,157.5)
        self.role_layer_2:addChild(role)
        self.img_name_right:setVisible(false)
    end
    
    self.selectRoleSp = nil
    self.selectRole = 0
    global.localMgr:setDataByKey(LOCAL_DATA_KEY.ROLE_INFO,info)
end

function SelectRoleWnd:enter_game_func()
    if self.selectRole == 0 then
        global.flyWordMgr:show("请先选择角色")
        return
    end
    print("start game......")
    global.popWndMgr:close(KONG_WNDS.SELECTE_ROLE_WND)
    global.popWndMgr:open(KONG_WNDS.MAIN_CITY_WND)
end

return SelectRoleWnd