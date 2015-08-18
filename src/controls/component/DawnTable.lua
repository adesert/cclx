--
-- Author: dawn
-- Date: 2014-11-06 13:42:44
--
local DawnTable = class("DawnTable", function ( )
	return cc.Layer:create()
end)

DawnTable.direct_h = 1 		-- 垂直移动
DawnTable.direct_v = 2 		-- 水平移动
--- width  遮罩宽
--- height 遮罩高
--- cellW  cell 宽
--- cellH  cell 高
--- direction  方向
--- cell_arr  cell list
function DawnTable:ctor(width,height,cellW,cellH,direction)
	self.m_width = width
	self.m_height = height
	self.c_w = cellW
	self.c_h = cellH
	self.m_direction = direction

	self:_init()
end

function DawnTable:_init()
	self.m_layer = display.newLayer()
	-- self.m_layer = display.newColorLayer(ccc4(0,0,0,255))
	self.m_layer:setContentSize(cc.size(self.m_width,self.m_height))
	self.m_layer:setPosition(0, 0)
	self:addChild(self.m_layer)
	
--	self.clip_layer = display.newClippingRegionNode(CCRect(0,0,self.m_width,self.m_height))
    self.clip_layer = cc.ClippingRectangleNode:create(cc.rect(0,0,self.m_width,self.m_height))
	self.clip_layer:setAnchorPoint(cc.p(0,0))
	self.clip_layer:setPosition(0,0)
	self.m_layer:addChild(self.clip_layer)

	self.m_content = display.newLayer()
	self.m_content:setPosition(0, 0)
	self.m_content:setTouchEnabled(true)
	self.m_content:setAnchorPoint(cc.p(0,0))
	self.m_content:setContentSize(cc.size(0,0))
	self.clip_layer:addChild(self.m_content)
	-- self.m_content:addNodeEventListener(cc.NODE_TOUCH_EVENT,handler(self, self._onTouch))

	if self.m_direction == DawnTable.direct_h then
		self.m_content:setPosition(0, self.m_height)
	end

	local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(handler(self,self._touchBegan),cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(handler(self,self._touchMoved),cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(handler(self,self._touchEnded),cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)

    self:registerScriptHandler(handler(self,self.onTouchEvent))
end

function DawnTable:setCells(cells,gap,lineNum)
	self.cells = cells
	self.gap = gap or 0
	print(#self.cells)
	self.nums = table.nums(self.cells)
	self.lineNum = lineNum or 1 -- 1 列，2列
	self.m_content:removeAllChildren()	
	for i=1,#self.cells do
		local v = self.cells[i]
		v:setAnchorPoint(cc.p(0,0))
		self.m_content:addChild(v)
	end

	self:_arrCells()
end

function DawnTable:_arrCells()
	local c_counts = 0
	for i=1,#self.cells do
		local v = self.cells[i]
		if self.m_direction == DawnTable.direct_v then
			if self.lineNum == 2 then
				local k = i % 2
				local hh = self.c_h
				if k == 0 then
					hh = 0
				end
				local ketty = (math.floor(i/2) + k - 1) * self.c_w
			-- 1	1 2  0  1/2 = 0 .. 1
			-- 2	3 4  1  2/2 = 1 .. 0
			-- 3	5 6  2  3/2 = 1 .. 1
			-- 4    7 8  3  4/2 = 2 .. 0
			-- n   2n-1   2n

			-- 5/2 = 2 .. 1
			-- 6/2 = 3 .. 0
			-- 7/2 = 3 .. 1

				v:setPosition(ketty,hh)
			else
				v:setPosition(self.c_w*(i-1), 0)
			end
		else
			if self.lineNum == 2 then
				local k = i % 2
				local ww = 0
				if k == 0 then
					ww = self.c_w
				end
				-- local te = -1*self.c_h*(i-1)
				local ketty = (math.floor(i/2) + k - 1) * self.c_h
				v:setPosition(ww, -ketty)
			else
				v:setPosition(0, -1*self.c_h*(i-1))
			end
		end
	end

	local n = #self.cells
	if self.m_direction == DawnTable.direct_v then
		if self.lineNum == 2 then
			local k = math.ceil(n/2)
			self.m_content_wh = k*self.c_w
		else
			self.m_content_wh = n*self.c_h
		end

		if self.m_content_wh < self.m_width then
			self.m_content_wh = self.m_width
		end
	else
		if self.lineNum == 2  then
			local k = math.ceil(n/2)
			self.m_content_wh = k*self.c_h
		else
			self.m_content_wh = n*self.c_h			
		end

		if self.m_content_wh < self.m_height then
			self.m_content_wh = self.m_height
		end
	end

	-- print("...........>>>>",self.m_content_wh)
end

function DawnTable:onTouchEvent(evt)
	if evt == "exit" then
		
	elseif evt == "enter" then
	
	end
end

function DawnTable:_onTouch(evt)
	if evt.name == "began" then
		self:_touchBegan(evt)
		return true
	elseif evt.name == "moved" then
		self:_touchMoved(evt)
	elseif evt.name == "ended" then
		self:_touchEnded(evt)
	elseif evt.name == "cancelled" then
		self:_touchEnded(evt)
	end
end

function DawnTable:_touchBegan(touch,event)
	self.m_move_direct = 0
--    local location = touch:getLocation()
--    local pox = touch:getStartLocation()
--    local prepox = touch:getPreviousLocation()

    return true
end

function DawnTable:_touchMoved(touch,event)
    local location = touch:getLocation()
    local prepox = touch:getPreviousLocation()
    
--	local gap_x = evt.x - evt.prevX
--	local gap_y = evt.y - evt.prevY

    local gap_x = location.x - prepox.x
    local gap_y = location.y - prepox.y
    
	local pox,poy = self.m_content:getPosition()
	if self.m_direction == DawnTable.direct_v then
		self.m_content:setPositionX(pox + gap_x)
		-- self.m_move_direct = gap_x >= 0 or -1
		self.m_move_direct = gap_x
	else
		self.m_content:setPositionY(poy + gap_y)
		self.m_move_direct = gap_y
	end
end

function DawnTable:_touchEnded(touch,event)

	local pox,poy = self.m_content:getPosition()
	if self.m_direction == DawnTable.direct_v then
		if pox > 0 then
            self.m_content:runAction(cc.MoveTo:create(0.1,{x = 0}))
--			transition.moveTo(self.m_content, {x = 0,time = 0.1})
		elseif pox + self.m_content_wh < self.m_width then
--			transition.moveTo(self.m_content, {x = self.m_width-self.m_content_wh,time = 0.1})
            self.m_content:runAction(cc.MoveTo:create(0.1,{x = self.m_width-self.m_content_wh}))
		end
	else
		if poy < self.m_height then
--			transition.moveTo(self.m_content, {y = self.m_height,time = 0.1})
            self.m_content:runAction(cc.MoveTo:create(0.1,{y = self.m_height}))
		elseif poy - self.m_content_wh > -self.m_height then
--			transition.moveTo(self.m_content, {y = self.m_height-self.m_content_wh,time = 0.1})
            self.m_content:runAction(cc.MoveTo:create(0.1,{y = self.m_height-self.m_content_wh}))
		end
	end
end

return DawnTable