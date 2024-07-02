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

function onSongStart()
	setProperty("camZooming", true)
end