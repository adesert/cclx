
local TaskManager = class("TaskManager",require("game.managers.BaseManager"))

function TaskManager:ctor( )
    self.super.ctor(self)
	self:_init()
end

function TaskManager:_init( )
    global.popWndMgr:register(SHOT_WNDS.TEST_WND,handler(self, self._openTask),handler(self,self._closeTask))
end

function TaskManager:_openTask( )
	if not self.m_task then
		self.m_task = require("game.modules.task.TaskWnd").new()
		global.sceneMgr:getLayer(LAYER_TYPE.MAIN_UI_LAYER):addChild(self.m_task)
	end
end

function TaskManager:_closeTask( )
	if self.m_task then
		self.m_task:removeFromParent()
		self.m_task = nil
	end
end

return TaskManager