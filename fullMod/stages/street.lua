function onCreate()
    if (not (lowQuality)) then
		makeLuaSprite('skybg', 'street/sky', -400, -400);
		setScrollFactor('skybg', 0.4, 0.4);
		scaleObject('skybg', 0.7, 0.7);
		addLuaSprite('skybg', false);
		
		makeLuaSprite('hue', 'street/ambient', -700, -450);
		setScrollFactor('hue', 1, 1);
		addLuaSprite('hue', true);

		makeLuaSprite('glow', 'street/glow');
		setScrollFactor('glow', 1, 1);
		setObjectCamera('glow', 'other')
		addLuaSprite('glow', true);

		setBlendMode("glow", 'add')

		makeAnimatedLuaSprite('leftBopper', 'street/bgPeople/pai-LCD', 450, 400);
		addAnimationByPrefix('leftBopper', 'idle', 'Idle', 24, false);
		scaleObject('leftBopper', 0.6, 0.6);
		updateHitbox('leftBopper')

		makeAnimatedLuaSprite('rightBopper', 'street/boppers', 1750, 500);
		addAnimationByPrefix('rightBopper', 'idle', 'rightBop', 24, false);
		scaleObject('rightBopper', 1.7, 1.7);
	
		makeAnimatedLuaSprite('frontBopper', 'street/boppers', 550, 1010);
		addAnimationByPrefix('frontBopper', 'idle', 'frontBop', 24, false);
		scaleObject('frontBopper', 2.5, 2.5);
	end
    makeLuaSprite('city', 'street/skyline', -800, -350);
	setScrollFactor('city', 0.7, 0.8);
	scaleObject('city', 0.7, 0.7);


    makeLuaSprite("street", "streetnew/street", -500, -1600)
    scaleObject('street', 1.6, 1.6);
    updateHitbox("street")

    makeLuaSprite("block", "streetnew/block", -500, -1600)
    scaleObject('block', 1.6, 1.6);
    updateHitbox("block")

    addLuaSprite("city", false)
    addLuaSprite("block", false)
    addLuaSprite("street", false)

    addLuaSprite('leftBopper', false);
	addLuaSprite('rightBopper', false);
	addLuaSprite('frontBopper', true);
end

function onStepHit()
	if(curStep % 4 == 0) then
		-- Code here
		playAnim('leftBopper', 'idle');
		playAnim('rightBopper', 'idle');
		playAnim('frontBopper', 'idle');
	end
end

local beat_events = {
    [4] = function() setPerspective("street", 0.75) end,
    [8] = function() setPerspective("street", 0.5) end,
    [12] = function() setVanishOffset(nil, -100) end,
    [16] = function() removePerspective("street") end
}

function onBeatHit()
    if beat_events[curBeat] then beat_events[curBeat]() end
end