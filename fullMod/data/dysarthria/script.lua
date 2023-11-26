function onCountdownStarted()
    doTweenY('textSkip','ten',-500,5,'circIn')
end

local cool = false
function onUpdate()
    if cool then
        if keyJustPressed('accept') then
            endSong()
        end
    end
	if not cool and misses > 10 then
        setProperty('inCutscene', true);
        playMusic('tea-time', 1)
		makeLuaSprite('end', 'endings/endingBad', 0, 0);
		setObjectCamera('end', 'camOther');
		setProperty('end.alpha', '0')
		addLuaSprite('end', true);
		doTweenAlpha('bad1', 'end', 1, 1, 'linear');
		cool = true
		return Function_Stop;
	end
    return Function_Continue;
end

function onCreate()
	makeLuaText('ten','Dont get less than 10 misses!',360,450,360)
    setTextSize('ten', 36)
    setTextAlignment('ten','center')
    setTextFont('ten', 'LEMONMILK-Medium.otf')
    addLuaText('ten')

	makeLuaSprite('blackbar','', 0, -30)
    makeGraphic('blackbar', 2000, 100, '000000')
    screenCenter('blackbar', 'X')
    setScrollFactor('blackbar', 0, 0)
    setObjectCamera('blackbar', 'hud')
    addLuaSprite('blackbar', false)

    makeLuaSprite('barthingie','', 0, 650)
    makeGraphic('barthingie', 2000, 100, '000000')
    setScrollFactor('barthingie', 0, 0)
    screenCenter('barthingie', 'X')
    setObjectCamera('barthingie', 'hud')
    addLuaSprite('barthingie', false)

	makeLuaSprite("blackback", '', 0, 0)
    makeGraphic("blackback", 3000, 2000, '000000')
    setScrollFactor("blackback", 0.0, 0.0)
    screenCenter("blackback", 'xy')
    setProperty("blackback.alpha", 0)
end

function onStepHit()
    if curStep == 1024 then
        addLuaSprite("blackback", false)
        doTweenAlpha("glassofmilk", "blackback", 0.5, 0.5, "linear")
    end
    if curStep == 1264 then
        removeLuaSprite("blackback", true)
        setProperty("blackback.alpha", 0)
    end
end