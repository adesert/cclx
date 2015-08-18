--
-- Author: dawn
-- Date: 2014-10-01 06:00:46
-- 主要加载ccb中得item，小面板等

local BaseCell = class("BaseCell", function ( )
    return cc.Layer:create()
end)

function BaseCell:ctor(path)
	self.m_callbacks = {}
	self.m_path = path
end

function BaseCell:initCCB( )
	self:_initCCB()
end

function BaseCell:setCallFunc(name,fn)
    self.m_callbacks[name] = fn
end

function BaseCell:_initCCB()
	--创建面板
	local ccbObj = require("game.base.CCBObject").new(global.pathMgr:getUI(self.m_path))
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

function BaseCell:addChild(child)
	self.m_ccb:addChild(child)
end

return BaseCell