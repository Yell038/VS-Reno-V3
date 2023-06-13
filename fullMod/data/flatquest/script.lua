function onCreate()
    makeLuaSprite('bars','bars',0,0)
	setScrollFactor('bars',160,90)
	addLuaSprite('bars',true)
    setProperty('bars.antialiasing',false)

	setObjectCamera('bars','camOther')
    scaleObject('bars',4,4)
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