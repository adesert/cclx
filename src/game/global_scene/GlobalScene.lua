---游戏场景
local GlobalScene = class("GlobalScene", function()
--    return cc.Scene:create()
    return cc.Scene:createWithPhysics()
end)

function GlobalScene:ctor()
    self:registerScriptHandler(function(evt) 
        if evt == "enter" then
            self:onEnter()
        elseif evt == "exit" then
            self:onExit()
        end
    end)
end

function GlobalScene:onEnter()
    print("scene--->enter")
end

function GlobalScene:onExit()
    print("scene--->exit")
--    global.objMgr:stop()
end

return GlobalScene
