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

		makeAnimatedLuaSprite('leftBopper', 'street/bgPeople/pai', 500, 400);
		addAnimationByPrefix('leftBopper', 'idle', 'pai_Idle', 24, false);
		scaleObject('leftBopper', 1.7, 1.7);
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

	makeLuaSprite('barfloor', 'street/street', -100, -150);
	setScrollFactor('barfloor', 1, 1);
	scaleObject('barfloor', 0.7, 0.7);

	makeLuaSprite('fastCar', 'limo/fastCarLol', -300, 160)
	setProperty('fastCar.active', true)
	
	addLuaSprite('city', false);
	addLuaSprite('fastCar', false);
	addLuaSprite('barfloor', false);
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