
--基础加载CCBui基础模块,主要加载大面板

local window = class("BaseWindow",function() return cc.Layer:create() end)

function window:ctor(path)
	self.m_callbacks = {}
	self.m_path = path

	self:_initCallFunc()
	self:_initCCB()
end

function window:_initCallFunc()
	self:overrideInitCallFunc()
end

function window:overrideInitCallFunc()
end

function window:_initCCB()
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

function window:addChild(child)
	self.m_ccb:addChild(child)
end

function window:getName()
	return nil
end

return window