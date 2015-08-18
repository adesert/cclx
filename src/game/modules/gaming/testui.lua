local testui = class("testui",require("game.base.BaseLayer"))

function testui:ctor()
	self.super.ctor(self)
end

function testui:_overrideInit()
    self:showMaskBG()
    self:setPassEvent(true)

    local ccbname = "testPhysicsParm"
    self.ccb = self:loadCCB(ccbname)
    self.ccb:setCallFunc("close_ui_func",handler(self,self._closeUI))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    self:_init()
end

function testui:_init()
    local rp = {-100,-70,-40,15}
    for i=1,4 do
        local label = self.ccb["ball_tf_"..i]
        local s = self:_addSlider(i,handler(self,self._ballFn))
        local vx,vy = label:getPosition()
        s:setPosition(vx+rp[i],vy-30)
        self:addChild(s)
        
        label = self.ccb["circle_tf_"..i]
        s = self:_addSlider(i,handler(self,self._circleFn))
        vx,vy = label:getPosition()
        s:setPosition(vx+rp[i],vy-30)
        self:addChild(s)
        
        label = self.ccb["rect_tf_"..i]
        s = self:_addSlider(i,handler(self,self._rectFn))
        vx,vy = label:getPosition()
        s:setPosition(vx+rp[i],vy-30)
        self:addChild(s)
        
        label = self.ccb["tars_tf_"..i]
        s = self:_addSlider(i,handler(self,self._tarsFn))
        vx,vy = label:getPosition()
        s:setPosition(vx+rp[i],vy-30)
        self:addChild(s)
        
        label = self.ccb["tar_tf_"..i]
        s = self:_addSlider(i,handler(self,self._tarFn))
        vx,vy = label:getPosition()
        s:setPosition(vx+rp[i],vy-30)
        self:addChild(s)
        
    end
end

function testui:_addSlider(tag,fn)
    local pRestrictSlider = cc.ControlSlider:create("extensions/sliderTrack.png","extensions/sliderProgress.png" ,"extensions/sliderThumb.png")
    pRestrictSlider:setAnchorPoint(cc.p(0.5, 1.0))
    
--    pRestrictSlider:setPosition(define_centerx,define_centery)
    pRestrictSlider:setTag(tag)     
    if tag == 4 then
        pRestrictSlider:setMinimumValue(100) 
        pRestrictSlider:setMaximumValue(10000) 
        pRestrictSlider:setMaximumAllowedValue(10000)
        pRestrictSlider:setMinimumAllowedValue(100)
        pRestrictSlider:setValue(10000)
    else
        pRestrictSlider:setMinimumValue(0.0) 
        pRestrictSlider:setMaximumValue(1.0) 
        pRestrictSlider:setMaximumAllowedValue(1)
        pRestrictSlider:setMinimumAllowedValue(0)
        pRestrictSlider:setValue(1.0)    
    end  
    --same with restricted
    pRestrictSlider:registerControlEventHandler(fn, cc.CONTROL_EVENTTYPE_VALUE_CHANGED)
    return pRestrictSlider
end

function testui:_ballFn(pSender)
    if nil == pSender then
        return
    end
    local pControl = pSender
    local strFmt = nil
    if pControl:getTag() == 1 then
        strFmt = pControl:getValue()
        ball_x_1 = tonumber(strFmt)
    elseif pControl:getTag() == 2 then
        strFmt = pControl:getValue()
        ball_x_2 = tonumber(strFmt)
    elseif pControl:getTag() == 3 then
        strFmt = pControl:getValue()
        ball_x_3 = tonumber(strFmt)
    elseif pControl:getTag() == 4 then
        strFmt = pControl:getValue()
        ball_x_4 = tonumber(strFmt)
    end
    if strFmt then
        local label = self.ccb["ball_tf_"..pControl:getTag()]
        label:setString(strFmt .. "")
    end
end

function testui:_circleFn(pSender)
    if nil == pSender then
        return
    end
    local pControl = pSender
    local strFmt = nil
    if pControl:getTag() == 1 then
        strFmt = pControl:getValue()
        circle_x_1 = tonumber(strFmt)
    elseif pControl:getTag() == 2 then
        strFmt = pControl:getValue()
        circle_x_2 = tonumber(strFmt)
    elseif pControl:getTag() == 3 then
        strFmt = pControl:getValue()
        circle_x_3 = tonumber(strFmt)
    elseif pControl:getTag() == 4 then
        strFmt = pControl:getValue()
        circle_x_4 = tonumber(strFmt)
    end
    if strFmt then
        local label = self.ccb["circle_tf_"..pControl:getTag()]
        label:setString(strFmt .. "")
    end
end

function testui:_rectFn(pSender)
    if nil == pSender then
        return
    end
    local pControl = pSender
    local strFmt = nil
    if pControl:getTag() == 1 then
        strFmt = pControl:getValue()
        rect_x_1 = tonumber(strFmt)
    elseif pControl:getTag() == 2 then
        strFmt = pControl:getValue()
        rect_x_2 = tonumber(strFmt)
    elseif pControl:getTag() == 3 then
        strFmt = pControl:getValue()
        rect_x_3 = tonumber(strFmt)
    elseif pControl:getTag() == 4 then
        strFmt = pControl:getValue()
        rect_x_4 = tonumber(strFmt)
    end
    if strFmt then
        local label = self.ccb["rect_tf_"..pControl:getTag()]
        label:setString(strFmt .. "")
    end
end


function testui:_tarsFn(pSender)
    if nil == pSender then
        return
    end
    local pControl = pSender
    local strFmt = nil
    if pControl:getTag() == 1 then
        strFmt = pControl:getValue()
        tars_x_1 = tonumber(strFmt)
    elseif pControl:getTag() == 2 then
        strFmt = pControl:getValue()
        tars_x_2 = tonumber(strFmt)
    elseif pControl:getTag() == 3 then
        strFmt = pControl:getValue()
        tars_x_3 = tonumber(strFmt)
    elseif pControl:getTag() == 4 then
        strFmt = pControl:getValue()
        tars_x_4 = tonumber(strFmt)
    end
    if strFmt then
        local label = self.ccb["tars_tf_"..pControl:getTag()]
        label:setString(strFmt .. "")
    end
end

function testui:_tarFn(pSender)
    if nil == pSender then
        return
    end
    local pControl = pSender
    local strFmt = nil
    if pControl:getTag() == 1 then
        strFmt = pControl:getValue()
        tar_x_1 = tonumber(strFmt)
    elseif pControl:getTag() == 2 then
        strFmt = pControl:getValue()
        tar_x_2 = tonumber(strFmt)
    elseif pControl:getTag() == 3 then
        strFmt = pControl:getValue()
        tar_x_3 = tonumber(strFmt)
    elseif pControl:getTag() == 4 then
        strFmt = pControl:getValue()
        tar_x_4 = tonumber(strFmt)
    end
    if strFmt then
        local label = self.ccb["tar_tf_"..pControl:getTag()]
        label:setString(strFmt .. "")
    end
end

function testui:_closeUI()
    global.popWndMgr:close(WND_NAME.test_ui)
    global.gamingMgr:applyFn(LEVEL_EVENT.RESTART_GAME)
end

return testui