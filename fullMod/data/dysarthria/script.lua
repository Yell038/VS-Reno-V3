function onStartCountdown()
	addLuaText('ten')
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
    setObjectCamera('ten','other')
    setTextFont('ten', 'LEMONMILK-Medium.otf')
end