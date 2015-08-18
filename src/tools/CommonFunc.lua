local CommonFunc = class("CommonFunc")

function CommonFunc:ctor()

end

--判断两个矩形是否碰撞
function CommonFunc:checkCollision(area1,area2)
    if area1.min_x > area2.max_x or area1.min_y > area2.max_y or area1.max_x < area2.min_x or area1.max_y < area2.min_y then
        return false
    end
    return true
end

function CommonFunc:checkCollision2(area1,area2)
    
    local dst = area1.y-area2.y
    dst = math.abs(dst)

    local  miny
    if area1.offect_y > area2.offect_y then
        miny = area2.offect_y
    else
        miny = area1.offect_y
    end  

    if dst > miny then
        return false
    end
    
    if area1.min_x > area2.max_x or area1.min_y > area2.max_y or area1.max_x < area2.min_x or area1.max_y < area2.min_y then
        return false
    end
    return true
end

function CommonFunc:checkCollisionSp(area1,area2)
	local rect = {
	   x = 0,
	   y = 0,
	   min_x = 0,
	   min_y = 0,
	   max_x = 0,
	   max_y = 0,
	   offect_x = 0,
	   offect_y = 0,
	   width = 0,
	   height = 0,
	}
    
    
    	
end

--- 判断一个点是否在一个矩形当中
function CommonFunc:checkPointInRect(pt,rect)
	if pt.x > rect.x+rect.width or pt.x<rect.x or pt.x > rect.x+rect.width or pt.y <rect.y or pt.y > rect.y+rect.height then
	   return false    -- 不在方框内
	end
	return true
end

--- 判断两个点之间的距离
function CommonFunc:twoPointDistance(pt1,pt2)
	local len
    local vx = pt1.x-pt2.x
    local vy = pt1.y-pt2.y
    return vx*vx + vy*vy
end

function CommonFunc:getNodePointLength(a,b)
	local ax,ay = a:getPosition()
	local bx,by = b:getPosition()
    local vx = ax-bx
    local vy = ay - by
    return vx*vx + vy*vy
end

--- 判断是否碰撞
function CommonFunc:checkCreatureCollision(rect1,rect2)
	
end

-- 判断一个点是否在另外两个点之间
function CommonFunc:checkPointBetweenPoint( p1,p2,p3 )
    if p1>=p2 and p1<=p3 then
        return true
    elseif p1<p2 and p1>p3 then
        return true
    end
    return false
end

--改变sprite帧
function CommonFunc:changePic(sp,path)
    local texture =  cc.Director:getInstance():getTextureCache():addImage(path)
    sp:setTexture(texture)
end

--设置按钮上的title
function CommonFunc:setTitleForBtn(btn,str,color)
    btn:setTitleForState(str,CCControlStateNormal)
    btn:setTitleForState(str,CCControlStateHighlighted)
    btn:setTitleForState(str,CCControlStateDisabled)
    if color then
        btn:setTitleColorForState(color,CCControlStateNormal)
        btn:setTitleColorForState(color,CCControlStateHighlighted)
        btn:setTitleColorForState(color,CCControlStateDisabled)
    end
    
    
end

-------------------------- filter 对图片进行filter ----------------------------
-- local __filters,__params  = global.commonFunc:getSpFilter()
-- self.bg = display.newFilteredSprite(imgName,__filters,__params)

function CommonFunc:getSpFilter()
    local t = {{"RGB", "GAUSSIAN_VBLUR", "GAUSSIAN_HBLUR"}, {nil, {3}, {3}}}
    
    local __filters, __params = unpack(t)
    
    if __params and #__params == 0 then
        __params = nil
    end
    -- local sp = display.newFilteredSprite("Images/background_1.jpg", __filters, __params)
    return __filters,__params
end

---------------------------- 离子效果 ----------------------------------
function CommonFunc:getParticleSystems(parName)
    -- local par = CCParticleSystemQuad:create("test_particle.plist")
    local par = cc.ParticleSystemQuad:create(parName)
    return par
end
---------------------------- end 离子效果 ---------------------------------

--------------------------- 贝塞尔曲线公式 -------------------------------------

------------------- 二次贝塞尔曲线公式 p0 起点，p1 控制点 p2 终点 t(0-1)-------------------
function CommonFunc:getTwoBezierPt(p0,p1,p2,t)
	local btx = (1-t)*(1-t)*p0.x + 2*t*(1-t)*p1.x + t*t*p2.x
	local bty = (1-t)*(1-t)*p0.y + 2*t*(1-t)*p1.y + t*t*p2.y
	return cc.p(btx,bty)
end

-------------------- 三次贝塞尔曲线 p0 起点 ,p1 控制点 ,p2 控制点 ,p3 终点 ,t 时间（0-1) ----------
function CommonFunc:getThreeBezierPt(p0,p1,p2,p3,t)
    local btx = p0.x*(1-t)*(1-t)*(1-t) + 3*p1.x*t*(1-t)*(1-t) + 3*p2.x*t*t*(1-t) + p3.x*t*t*t
    local bty = p0.y*(1-t)*(1-t)*(1-t) + 3*p1.y*t*(1-t)*(1-t) + 3*p2.y*t*t*(1-t) + p3.y*t*t*t
    return cc.p(btx,bty)
end

--------------------------- end 贝塞尔曲线公式 -------------------------------------

function CommonFunc:pauseAllActions()
--    cc.Director:getInstance():getActionManager():pauseAllRunningActions()
end

function CommonFunc:resumeAllActions()
--	cc.Director:getInstance():getActionManager():resumeTarget(target)
end

return CommonFunc