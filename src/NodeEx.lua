
--[[
    node 的触摸事件
]]--
function node_touchEvent(node,beganfn,movefn,endfn,registerfn)
    local listener = cc.EventListenerTouchOneByOne:create()
    
    listener:setSwallowTouches(true)
    
    if beganfn then
        listener:registerScriptHandler(beganfn,cc.Handler.EVENT_TOUCH_BEGAN)
    end
    if movefn then
        listener:registerScriptHandler(movefn,cc.Handler.EVENT_TOUCH_MOVED)
    end
    
    if endfn then
        listener:registerScriptHandler(endfn,cc.Handler.EVENT_TOUCH_ENDED)
    end
    
    local eventDispatcher = node:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, node)
    if registerfn then
        node:registerScriptHandler(registerfn)
    end
    return listener
end