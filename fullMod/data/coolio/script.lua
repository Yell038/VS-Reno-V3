playVideo = true;

function onStartCountdown()
	if isStoryMode and not seenCutscene then
		if playVideo then --Video cutscene plays first
			startVideo('coolioCut'); --Play video file from "videos/" folder
			playVideo = false;
			return Function_Stop; --Prevents the song from starting naturally
		end
	end
	return Function_Continue; --Played video and dialogue, now the song can start normally
end

function onCreate()
    makeLuaSprite("blackback", '', 0, 0)
    makeGraphic("blackback", 3000, 2000, '000000')
    setScrollFactor("blackback", 0.0, 0.0)
    screenCenter("blackback", 'xy')
    setProperty("blackback.alpha", 0)
end
function onStepHit()
if curStep == 624 then
	addLuaSprite("blackback", false)
	doTweenAlpha("glassofmilk", "blackback", 0.8, 2.3, "linear")
end
if curStep == 640 then
	removeLuaSprite("blackback", true)
	setProperty("blackback.alpha", 0)
end
end