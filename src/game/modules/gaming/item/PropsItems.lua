--[[
    道具 cell
]]--

local PropsItems = class("PropsItems",function ()
	return cc.Layer:create()
end)

function PropsItems:ctor(id,n)
    self.m_id = id
    self.m_num = n
    self.propsImg = nil
    self.propsNum = nil
    
    self:_init()
end

function PropsItems:_init()
    local path = global.pathMgr:getFightImg("props_"..self.m_id)
    local cell = cc.Sprite:create(path)
    
    local menuitem = cc.MenuItemSprite:create(cell,cell)
    menuitem:registerScriptTapHandler(handler(self,self._onTouchItem))
    
    local  menu = cc.Menu:create()
    menu:addChild(menuitem)
    self:addChild(menu)
    menu:setPosition(0,0)
    
    path = global.pathMgr:getGameFont("font1.fnt")

    self.propsNum = cc.Label:createWithBMFont(path, self.m_num .. "")
    self:addChild(self.propsNum)
    self.propsNum:setPosition(23,-18)
    self.propsNum:setColor(cc.c3b(0,255,0))
end

function PropsItems:_onTouchItem(sender)
   global.gamingMgr:applyFn(LEVEL_EVENT.CLICK_PROPS_EVENT,self.m_id)
   self:setPropsNums()
end

function PropsItems:setPropsNums()
    if self.m_num <=0 then
        return
    end
    self.m_num = self.m_num-1
    self.propsNum:setString(self.m_num .. "")
end

function PropsItems:getNums()
    return self.m_num
end

return PropsItems