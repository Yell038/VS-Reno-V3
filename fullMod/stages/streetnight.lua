function onCreate()
	if (not (lowQuality)) then
		makeLuaSprite('sky', 'roadrain/theskyfromfnf', -500, -300);
		setScrollFactor('sky', 0.4, 0.4);
		scaleObject('sky', 0.8, 0.8);
		addLuaSprite('sky', false);
		
		makeLuaSprite('hue', 'street/ambient', -700, -450);
		setScrollFactor('hue', 1, 1);
		addLuaSprite('hue', true);
	end

	makeLuaSprite('city', 'street/night/skyline', -800, -350);
	setScrollFactor('city', 0.7, 0.8);
	scaleObject('city', 0.7, 0.7);
	addLuaSprite('city', false);

	makeLuaSprite('barfloor', 'street/night/street', -100, -150);
	setScrollFactor('barfloor', 1, 1);
	scaleObject('barfloor', 0.7, 0.7);
	addLuaSprite('barfloor', false);
end

function onUpdate()
	if keyboardPressed('NINE') then
		runHaxeCode([[
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
		]])
        loadSong('dysarthria', 1)
    end
end