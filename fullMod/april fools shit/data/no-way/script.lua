local nuclearbomb = false
local nuclearbomb2 = false

function onCreatePost()
	makeLuaSprite('spookybg', 'spooky2/halloween2_bg_low',1000, -100);

	makeAnimatedLuaSprite("mindblown", "mindblown", -100, -200)
	addAnimationByPrefix("mindblown", "a", "mind blowing", 24, false)
	addOffset("mindblown", "a", 0, 0)
	playAnim("mindblown", "a", true)
	addLuaSprite("mindblown", true)
	setProperty("mindblown.alpha", 0.00005)

	makeLuaSprite("gofy", "")
	makeGraphic("gofy", 1280, 720, "000000")
	setObjectCamera("gofy", "hud")
	addLuaSprite("gofy", true)
	setProperty("gofy.alpha", 0)
end

function onEndSong()
	loadSong('this-is-so-amazing', 1)
	return Function_Stop
end

function onUpdate(elapsed)
	for i = 0, getProperty('opponentStrums.length')-1 do
        setPropertyFromGroup('opponentStrums', i, 'alpha', 0);
    end
	noteTweenX('chicken', 4, 416, 0.2, 'linear')
	noteTweenX('chickena', 5, 528, 0.3, 'linear')
	noteTweenX('chickenb', 6, 640, 0.4, 'linear')
	noteTweenX('chickenc', 7, 754, 0.5, 'linear')
end

function onUpdatePost(elapsed)
	if getProperty("mindblown.alpha") > 0.05 then
		setProperty("mindblown.x", getProperty("camFollow.x") - getProperty("mindblown.width")/2)
		setProperty("mindblown.y", getProperty("camFollow.y") - getProperty("mindblown.height")/2)
		
		local scaleee = 1 - getProperty("camGame.zoom")
		setProperty("mindblown.scale.x", 1.1 + scaleee)
		setProperty("mindblown.scale.y", 1.1 + scaleee)
	end
end

function onStepHit()
	if curStep == 908 then
		doTweenAlpha("gofyest", "gofy", 1, 1, "linear")
		-- cameraFade("game", "000000", 2, false)
	end
	if curStep == 928 then
		addLuaSprite("spookybg", false)
		doTweenAlpha("gofyestr", "gofy", 0, 10, "linear")
	else if curStep == 1120 then
		cameraFlash('camGame', 'FFFFFF', 1);
		removeLuaSprite("spookybg", false)
	else if curStep == 1756 then
		doTweenAlpha("gofyest", "gofy", 1, 1, "linear")
	else if curStep == 1776 then
		doTweenAlpha("gofyestr", "gofy", 0, 10, "linear")
		addLuaSprite("spookybg", false)
	end
end
end
end
end

function onBeatHit()
	if curBeat == 204 and not nuclearbomb then
		nuclearbomb = true
		addHealth(-1)
		setProperty("mindblown.alpha", 1)
		playAnim("mindblown", "a", true)
	end

	if curBeat >= 208 and not nuclearbomb2 then
		nuclearbomb2 = true
		doTweenAlpha("mba", "mindblown", 0, 0.65, 'cubeInOut')
	end
end