function onCreate()
    -- background shit
	makeLuaSprite('sky', 'roadrain/theskyfromfnf', -500, -300);
	setScrollFactor('sky', 0.3, 0.1);
	scaleObject('sky', 0.8, 0.8);

	makeLuaSprite('backBuildings', 'roadrain/billdings', -600, -500);
	setScrollFactor('backBuildings', 0.7, 0.7);
    scaleObject('backBuildings', 0.9, 0.9);
    updateHitbox('backBuildings')
	
	makeLuaSprite('ground', 'roadrain/thefloor', -635, -200)

	makeLuaSprite('lights', 'roadrain/lights', -800, -350);
	setScrollFactor('lights', 0.9, 0.9);

    makeLuaSprite('tint', 'roadrain/tint');
    setObjectCamera('tint', 'other');

    makeAnimatedLuaSprite('fgRain1', 'roadrain/NewRAINLayer01', -500, -300)
	setScrollFactor('fgRain1', 0.3, 0.1);
	scaleObject('fgRain1', 2, 2)
	setProperty('fgRain1.alpha', 0.75)
	updateHitbox('fgRain1')
    addAnimationByPrefix('fgRain1', 'play', 'RainFirstlayer instance 1', 24, true)

    makeAnimatedLuaSprite('fgRain2', 'roadrain/NewRAINLayer02', -500, -300)
	setScrollFactor('fgRain2', 0.3, 0.1);
	scaleObject('fgRain2', 2, 2)
	updateHitbox('fgRain2')
    addAnimationByPrefix('fgRain2', 'play', 'RainFirstlayer instance 1', 24, true)

    makeLuaSprite('fastCar', 'fastCarLol', -300, 380)
	setProperty('fastCar.active', true)

	addLuaSprite('sky', false);
	addLuaSprite('backBuildings', false);
	addLuaSprite('ground', false);
    addLuaSprite('fastCar', true);
	addLuaSprite('lights', true);
    addLuaSprite('tint', true);
    addLuaSprite('fgRain1', true);
    addLuaSprite('fgRain2', true);

    playAnim('fgRain1', 'play', true)
    playAnim('fgRain2', 'play', true)

	resetFastCar()
end

local fastCarCanDrive = true
function onBeatHit()
	if getRandomBool(10) and fastCarCanDrive then
		fastCarDrive()
	end
end

function resetFastCar()
	setProperty('fastCar.x', -12600)
	setProperty('fastCar.y', 380)
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