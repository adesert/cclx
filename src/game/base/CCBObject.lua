local CCBObject = class("CCBObject")

function CCBObject:ctor(filePath,owner)
	---------------------------------变量定义开始-------------------------------------
    self.owner = owner
	--owner 导出对象
	self.owner_nodes = {}
	--owner 回调函数
	self.owner_callBacks = {}
	--document mAnimationManager
	self.doc_animation_managers = {}
	--document 导出对象
	self.doc_nodes = {}
	--document 回调函数
	self.doc_callBacks = {}	
	--owner名,为空则为不设置父节点
	self.strFilePath = filePath
	--actionmanager
	self.animationManager = nil
	---------------------------------变量定义结束-------------------------------------
end

function CCBObject:setDocumentCallBacks(callBackName,handle)
	self.doc_callBacks[callBackName] = handle
end

function CCBObject:setOwnerCallBacks(callBackName,handle)
	self.owner_callBacks[callBackName] = handle
end

function CCBObject:getDocAnimationManager(docName)
	return self.doc_animation_managers[docName]
end

function CCBObject:setDocAnimationManager(docName,mgr)
	 self.doc_animation_managers[docName] = mgr
end

function CCBObject:getDocumentNode(NodeName)
	return self.doc_nodes[NodeName]
end

function CCBObject:getOwnerNode(NodeName)
	return self.owner_nodes[NodeName]
end

function CCBObject:getAnimationManager()
	return self.animationManager
end

function CCBObject:loadCCBNode()
    local proxy = cc.CCBProxy:create()
    local ccbReader = proxy:createCCBReader()
    local node = proxy:readCCBFromFile(self.strFilePath,ccbReader,true)
--    local node      = ccbReader:load(self.strFilePath)
--    self.animationManager  = ccbReader:getAnimationManager()

    self.animationManager = ccbReader:getActionManager()
--    print("self.animationManager --- >",tolua.type(self.animationManager))
    local rootName  = ""
    --------------------------------------- owner --------------------------------------
    if nil ~= self.owner then
        local ownerCallbackNames = ccbReader:getOwnerCallbackNames() 
        local ownerCallbackNodes = ccbReader:getOwnerCallbackNodes()
        local ownerCallbackControlEvents = ccbReader:getOwnerCallbackControlEvents()
        local i = 1
        for i = 1,table.getn(ownerCallbackNames) do
            local callbackName =  ownerCallbackNames[i]
            local callbackNode =  tolua.cast(ownerCallbackNodes[i],"cc.Node")
--            local cbName = callbackName:getCString()
            print("ownner callfn ----name :",callbackName,callbackName)
            if "function" == type(self.owner_callBacks[callbackName]) then
                -- proxy:setCallback(callbackNode, owner[callbackName], ownerCallbackControlEvents[i])
                proxy:setCallback(callbackNode,self.owner_callBacks[callbackName])
            else
                print("Warning: Cannot find owner's lua function:" .. ":" .. callbackName .. " for ownerVar selector")
            end
        end

        --Variables
        local ownerOutletNames = ccbReader:getOwnerOutletNames() 
        local ownerOutletNodes = ccbReader:getOwnerOutletNodes()

        for i = 1, table.getn(ownerOutletNames) do
            local outletName = ownerOutletNames[i]
            local outletNode = tolua.cast(ownerOutletNodes[i],"cc.Node")
            -- owner[outletName] = outletNode

            -- self.owner_nodes[outletName:getCString()] = tolua.cast(outletNode, proxy:getNodeTypeName(outletNode))
            self.owner_nodes[outletName] = outletNode
        end
    end
    
    --------------------------------------------设置Documents-----------------------------------------
    local nodesWithAnimationManagers = ccbReader:getNodesWithAnimationManagers()
    local animationManagersForNodes  = ccbReader:getAnimationManagersForNodes()
    if nodesWithAnimationManagers == nil then
        error(self.strFilePath .. "   javascript controlled!!")
    end
    
    for i = 1 , table.getn(nodesWithAnimationManagers) do
        local innerNode = tolua.cast(nodesWithAnimationManagers[i], "cc.Node")
        local animationManager = tolua.cast(animationManagersForNodes[i], "cc.CCBAnimationManager")
        local documentControllerName = animationManager:getDocumentControllerName()
        if "" ~= documentControllerName then
            self.doc_animation_managers[documentControllerName] = animationManager
        end
        
        -----------------------------------------设置document回调函数-----------------------------------------
        local documentCallbackNames = animationManager:getDocumentCallbackNames()
        local documentCallbackNodes = animationManager:getDocumentCallbackNodes()
        local documentCallbackControlEvents = animationManager:getDocumentCallbackControlEvents()
        
        for i = 1,table.getn(documentCallbackNames) do
            local callbackName = documentCallbackNames[i]
            local callbackNode = tolua.cast(documentCallbackNodes[i],"cc.Node")
            
--            if "" ~= documentControllerName and nil ~= ccb[documentControllerName] then
            if "function" == type(self.doc_callBacks[callbackName]) then
--                    proxy:setCallback(callbackNode, ccb[documentControllerName][callbackName], documentCallbackControlEvents[i])
                proxy:setCallback(callbackNode,self.doc_callBacks[callbackName])
                else
                    print("Warning: Cannot found lua function [" .. documentControllerName .. ":" .. callbackName .. "] for docRoot selector")
                end
--            end
        end
        
        -----------------------------------------设置document导出对象 -----------------------------------------
        local documentOutletNames = animationManager:getDocumentOutletNames()
        local documentOutletNodes = animationManager:getDocumentOutletNodes()
        for i = 1, table.getn(documentOutletNames) do
            local outletName = documentOutletNames[i]
            local outletNode = tolua.cast(documentOutletNodes[i],"cc.Node")

--            if nil ~= ccb[documentControllerName] then
--                ccb[documentControllerName][outletName] = tolua.cast(outletNode, proxy:getNodeTypeName(outletNode))
--            end

--            print("-------------kkkkkkk-->>>",outletName,tolua.type(outletName))
            self.doc_nodes[outletName] = tolua.cast(outletNode, proxy:getNodeTypeName(outletNode))
        end
        
        -----------------------------------------设置时间轴关键帧document/owner回调函数 -----------------------------------------
        local keyframeCallbacks = animationManager:getKeyframeCallbacks()
        for i = 1 , table.getn(keyframeCallbacks) do
            local callbackCombine = keyframeCallbacks[i]
            local beignIndex,endIndex = string.find(callbackCombine,":")
            local callbackType    = tonumber(string.sub(callbackCombine,1,beignIndex - 1))
            local callbackName    = string.sub(callbackCombine,endIndex + 1, -1)
            --Document callback

            if 1 == callbackType then
                if "function" == type(self.doc_callBacks[callbackName]) then
                    local callfunc = cc.CallFunc:create(self.doc_callBacks[callbackName])
                    animationManager:setCallFuncForLuaCallbackNamed(callfunc, callbackCombine)	
                end
            elseif 2 == callbackType then
                if "function" == type(self.owner_callBacks[callbackName]) then
                    local callfunc = cc.CallFunc:create(self.owner_callBacks[callbackName])
                    animationManager:setCallFuncForLuaCallbackNamed(callfunc, callbackCombine)	
                end
            end
            
            --start animation
            local autoPlaySeqId = animationManager:getAutoPlaySequenceId()
            if -1 ~= autoPlaySeqId then
                animationManager:runAnimationsForSequenceIdTweenDuration(autoPlaySeqId, 0)
            end
        end
    end
    
    return node
end

return CCBObject
