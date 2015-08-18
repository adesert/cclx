
local FrameSpriteCacheManager = class("FrameSpriteCacheManager")

function FrameSpriteCacheManager:ctor()
	self:_init()
end

function FrameSpriteCacheManager:_init()
    
end

function FrameSpriteCacheManager:cacheFrame(frame,frameName)
    cc.SpriteFrameCache:getInstance():addSpriteFrames(frame,frameName)
end

function FrameSpriteCacheManager:removeFrame(plist)
    cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile(plist)
end

return FrameSpriteCacheManager