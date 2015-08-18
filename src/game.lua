--游戏流程
game = {}
local hooker = require("game_hook")

function game.update()
    hooker:on_update()
    hooker.on_enterGame()

    global.sceneMgr:enterGame()
    
--    global.popWndMgr:open(SHOT_WNDS.TEST_WND)
--    global.popWndMgr:open(SHOT_WNDS.FIGHT_WND)

--    global.popWndMgr:open(SF_WNDS.LOGIN_WNDS)
--
--    if true then
--    	return
--    end
    
    local info = global.localMgr:getDataByKey(LOCAL_DATA_KEY.ROLE_INFO)
    local isCreate = true
    for key, var in pairs(info) do
    	if var.roleid>0 then
    		isCreate = false
    		break
    	end
    end
    if isCreate == false then
        global.popWndMgr:open(KONG_WNDS.SELECTE_ROLE_WND)
    else
        global.popWndMgr:open(KONG_WNDS.CREATE_ROLE_WND)
    end
end

function game.test()
    local gameScene = cc.Scene:create()

    game.test2(gameScene)

    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(gameScene)
    else
        cc.Director:getInstance():runWithScene(gameScene)
    end
end

function game.test2(scene)
    local layer = cc.Layer:create()
--    local layer = cc.LayerColor:create(cc.c4b(255,0,0,255),640,1136)
    print("-----------------------------------------------------")
    print(tolua.type(layer))
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(function(touch, event)
        --        print(tolua.type(touch),tolua.type(event))
        local location = touch:getLocation()
        local pox = touch:getStartLocation()
        local prepox = touch:getPreviousLocation()

        local e = event:getEventCode()
        print(location.x,location.y,pox.x,pox.y,e)
        print(prepox.x,prepox.y)

        return true
    end,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(function(touch,event)
        local location = touch:getLocation()
        local pox = touch:getStartLocation()
        local prepox = touch:getPreviousLocation()

        local e = event:getEventCode()
        print(location.x,location.y,pox.x,pox.y,e)
        print(prepox.x,prepox.y)

    end,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(function(touch,event)
        local location = touch:getLocation()
        local pox = touch:getStartLocation()
        local prepox = touch:getPreviousLocation()

        local e = event:getEventCode()
        print(location.x,location.y,pox.x,pox.y,e)
        print(prepox.x,prepox.y)

        print("-------->>>",tolua.type(layer))
--        layer:removeFromParent()
    end,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)

    layer:registerScriptHandler(function(evt)
        print("register - >",evt)
        if evt == "exit" then

        elseif evt == "enter" then

        end
    end)
    
    scene:addChild(layer)
    
    local bg = cc.Sprite:create(global.pathMgr:getPics("test_bg.png"))
    bg:setPosition(center_x,center_y)
    scene:addChild(bg)
    
    local t = cc.Sprite:create(global.pathMgr:getPics("test_r.png"))
    scene:addChild(t)
    t:setScale(0.35)
    t:setPosition(center_x,center_y)
end

return game