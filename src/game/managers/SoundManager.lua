--
-- Author: dawn
-- Date: 2014-10-09 00:30:25
--
local SoundManager = class("SoundManager")

function SoundManager:ctor( )
	
	local bg = "sound/game_bg.mp3"
	self:playMusic(bg,true)
end

function SoundManager:playMusic( key,loop )
	-- local sound = global.proto.sound_config(id)
	-- audio.playSound(global.pathMgr:getSoundEffect(sound.res), sound.is_loop == 1)
    
--    AudioEngine.playMusic(key,loop)
end

function SoundManager:playEffect(key,loop)
    AudioEngine.playEffect(key,loop)
end

return SoundManager