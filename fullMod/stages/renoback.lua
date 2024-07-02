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

		makeAnimatedLuaSprite('rightBopper', 'street/bgPeople/fanboyLCD', 1850, 400);
		addAnimationByPrefix('rightBopper', 'idle', 'Idle', 24, false);
		scaleObject('rightBopper', 0.8, 0.8);
		updateHitbox("rightBopper")
	
		makeAnimatedLuaSprite('frontBopper', 'street/bgPeople/fgCharsLCD', 300, 700);
		addAnimationByPrefix('frontBopper', 'idle', 'Idle', 24, false);
		scaleObject('frontBopper', 0.8, 0.8);
		setScrollFactor('frontBopper', 1.1, 0.8);
		updateHitbox("frontBopper")
	end

	makeLuaSprite('city', 'street/skyline', -800, -350);
	setScrollFactor('city', 0.7, 0.8);
	scaleObject('city', 0.7, 0.7);

	makeLuaSprite('barfloor', 'street/street', -100, -150);
	setScrollFactor('barfloor', 1, 1);
	scaleObject('barfloor', 0.7, 0.7, true);

	makeLuaSprite('fastCar', 'fastCarLol', -300, 160)
	setProperty('fastCar.active', true)
	
	addLuaSprite('city', false);
	addLuaSprite('fastCar', false);
	addLuaSprite('barfloor', false);
	addLuaSprite('leftBopper', false);
	addLuaSprite('rightBopper', false);
	addLuaSprite('frontBopper', true);

	resetFastCar()
end

function onStartCountdown()
	triggerEvent("glow flash")
	cameraFlash("game", "ffffff", 2, true)
end

function onStepHit()
	if(curStep % 4 == 0) then
		-- Code here
		playAnim('leftBopper', 'idle', true);
		playAnim('rightBopper', 'idle', true);
		playAnim('frontBopper', 'idle', true);
	end
end

local fastCarCanDrive = true
function onBeatHit()
	if getRandomBool(10) and fastCarCanDrive then
		fastCarDrive()
	end
end

function resetFastCar()
	setProperty('fastCar.x', -12600)
	setProperty('fastCar.y', getRandomInt(140, 250))
	setProperty('fastCar.velocity.x', 0)
	fastCarCanDrive = true;
end

function fastCarDrive() -- vroom
	sound = string.format('carPass%i', getRandomInt(0, 1))
	playSound(sound, 0.7)
	setProperty('fastCar.velocity.x', getRandomInt(170, 22) / getPropertyFromClass('flixel.FlxG', 'elapsed') * 3)
	fastCarCanDrive = false
	runTimer('carTimer', 2, 1)
end

function onTimerCompleted(t, l, ll)
	if t == 'carTimer' then
		resetFastCar()
	end
end

---
--- @param eventName string
--- @param value1 string
--- @param value2 string
--- @param strumTime float
---
function onEvent(eventName, value1, value2, strumTime)
	if eventName == 'end song thing' then
		removeLuaSprite("glow", true)
	end
end

function onSoundFinished(tag)
	if tag == 'birdnoise' then
		playSound("birds", 1, "birdnoise")
	end
end

function onCountdownStarted()
	playSound("birds", 0, "birdnoise")
	soundFadeIn('birdnoise', 1)
end

function onGameOverConfirm(isNotGoingToMenu)
	soundFadeOut("birdnoise", 3)
end

---
--- @param swagCounter int
---
function onCountdownTick(swagCounter)
	playAnim('leftBopper', 'idle', true);
		playAnim('rightBopper', 'idle', true);
		playAnim('frontBopper', 'idle', true);
end