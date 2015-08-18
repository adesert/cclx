
local LevelCCB = class("LevelCCB",function ()
    return cc.Node:create()
end)

function LevelCCB:ctor(path)
    self.m_callbacks = {}
    self.m_path = path
end

function LevelCCB:initCCB()
    self:_initCCB()
end

function LevelCCB:_initCCB()
    --创建面板
    local ccbObj = require("game.base.CCBObject").new(global.pathMgr:getLevelCCB(self.m_path))
    for k,v in pairs(self.m_callbacks) do 
        ccbObj:setDocumentCallBacks(k,v)
    end
    self.m_ccb = ccbObj:loadCCBNode()
    for k,v in pairs(ccbObj.doc_nodes) do
        self[k] = v
    end

    self.m_ccb:setPosition(0,0)

    getmetatable(self).addChild(self,self.m_ccb)
end

function LevelCCB:addChild(child)
    self.m_ccb:addChild(child)
end

return LevelCCB
