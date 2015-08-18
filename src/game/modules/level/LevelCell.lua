
local LevelCell = class("LevelCell",require("game.base.BaseLayer"))

function LevelCell:ctor()
	self.super.ctor(self)
end

function LevelCell:_overrideInit()
    self.ccb = self:loadCCB("level_cell")
    
    self.ccb:initCCB()
    self:addChild(self.ccb)

    self:_init()
    self:_initdata()
end

function LevelCell:_init()
    
end

function LevelCell:_initdata()
    
end

function LevelCell:setData(data)
--{id=1,img_name = "level_ui_14",img_content = "level_ui_21",star = 2},
	self.m_data = data
    
    local rs = "imgs/level_ui/"..data.img_content..".png"
    local s = cc.Sprite:create(rs)
    self.ccb["img_content"]:setSpriteFrame(cc.SpriteFrame:create(rs,s:getContentSize()))
    
    rs = "imgs/level_ui/" ..data.img_name..".png"
    s = cc.Sprite:create(rs)
    self.ccb["img_name"]:setSpriteFrame(cc.SpriteFrame:create(rs,s:getContentSize()))
    
    if data.star>0 then
    	self.ccb["img_lock"]:setVisible(false)
        self.ccb["img_lock_s"]:setVisible(false)
        
        for i=1, 3 do
        	if i>data.star then
                self.ccb["img_star_"..i]:setVisible(false)
            else
                self.ccb["img_star_"..i]:setVisible(true)
        	end
        end
    else
        self.ccb["img_lock"]:setVisible(true)
        self.ccb["img_star_1"]:setVisible(false)
        self.ccb["img_star_2"]:setVisible(false)
        self.ccb["img_star_3"]:setVisible(false)
        self.ccb["img_lock_s"]:setVisible(true)
    end
end

function LevelCell:clear()
	
end

return LevelCell