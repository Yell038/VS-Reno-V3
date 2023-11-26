function onCreate()
	if (not (lowQuality)) then
		makeLuaSprite('skybg', 'street/night/sky', -400, -400);
		setScrollFactor('skybg', 0.4, 0.4);
		scaleObject('skybg', 0.7, 0.7);
		addLuaSprite('skybg', false);
		
		makeLuaSprite('hue', 'street/ambient', -700, -450);
		setScrollFactor('hue', 1, 1);
		addLuaSprite('hue', true);

		makeLuaSprite('glow', 'street/night/glow');
		setScrollFactor('glow', 1, 1);
		setObjectCamera('glow', 'other')
		addLuaSprite('glow', true);

		setBlendMode("glow", 'add')
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
        loadSong('dysarthria', 0)
    end
end