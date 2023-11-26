playVideo = true;


function onStartCountdown()
	if isStoryMode and not seenCutscene then
		if playVideo then --Video cutscene plays first
			startVideo('jaq1'); --Play video file from "videos/" folder
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

    --HudAssets = {'healthBarBG','healthBar','scoreTxt','iconP1','iconP2','timeBar','timeBarBG','timeTxt'}
end

function onCreatePost()
    setProperty("healthBarBG.alpha", 0)
    setProperty("healthBar.alpha", 0)
    setProperty("iconP1.alpha", 0)
    setProperty("iconP2.alpha", 0)
    setProperty("scoreTxt.alpha", 0)
end

function onStepHit()
    if curStep == 128 then
        setProperty("healthBarBG.alpha", 1)
        setProperty("healthBar.alpha", 1)
        setProperty("iconP1.alpha", 1)
        setProperty("iconP2.alpha", 1)
        setProperty("scoreTxt.alpha", 1)
    end
    if curStep == 768 then
        addLuaSprite("blackback", false)
        doTweenAlpha("glassofmilk", "blackback", 0.5, 0.5, "linear")
    end
    if curStep == 784 then
        removeLuaSprite("blackback", true)
        setProperty("blackback.alpha", 0)
    end
end

function onCountdownStarted()
    cameraFlash("game", "000000", 13)
end