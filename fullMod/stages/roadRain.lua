function onCreate()
    -- background shit
if not lowQuality then
	makeLuaSprite('frontBuildings', 'roadrain/frontBg', -600, -100);
	setScrollFactor('frontBuildings', 0.6, 0.6);
    scaleObject('frontBuildings', 0.9, 0.9);
    updateHitbox('frontBuildings')
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
end
	makeLuaSprite('sky', 'roadrain/theskyfromfnf', -500, -300);
	setScrollFactor('sky', 0.3, 0.1);
	scaleObject('sky', 0.8, 0.8);


	makeLuaSprite('backBuildings', 'roadrain/backBg', -600, -100);
	setScrollFactor('backBuildings', 0.5, 0.5);
    scaleObject('backBuildings', 0.9, 0.9);
    updateHitbox('backBuildings')

	

	makeLuaSprite('backing', 'roadrain/backing', -650, -100);
	setScrollFactor('backing', 0.7, 0.7);
    scaleObject('backing', 0.9, 0.9);
    updateHitbox('backing')
	
	makeLuaSprite('ground', 'roadrain/thefloor', -635, -200)
	updateHitbox("ground")

	makeLuaSprite('lights', 'roadrain/lights', -800, -350);
	setScrollFactor('lights', 0.9, 0.9);
	updateHitbox("lights")

	makeLuaSprite('flashthing','')
	makeGraphic('flashthing',1280, 720, '0xFFFFFFFF')
	screenCenter("flashthing", 'xy')
	setObjectCamera('flashthing', 'hud');
	setProperty("flashthing.alpha", 0)
	addLuaSprite("flashthing", false)

    makeLuaSprite('tint', 'roadrain/tint');
    setObjectCamera('tint', 'other');
	setBlendMode("tint", 'overlay')

   
 

    makeLuaSprite('fastCar', 'fastCarLol', -300, 380)
	setProperty('fastCar.active', true)

	addLuaSprite('sky', false);
	addLuaSprite('backBuildings', false);
	addLuaSprite('frontBuildings', false);
	addLuaSprite('backing', false);
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
	if t == "thunderthing" then
		playSound("thunder", 1, "thunders")
		setProperty("flashthing.alpha", 0.3)
		doTweenAlpha("frer", "flashthing", 0, 0.5, "linear")
	end
end

function onSoundFinished(tag)
	if tag == 'soundrain' then
		playSound("rain", 1, "soundrain")
	end
	if tag == 'thunders' then
		runTimer("thunderthing", getRandomInt(5, 15))
	end
end

function onCountdownStarted()
	playSound("rain", 0, "soundrain")
	soundFadeIn('soundrain', 1)
end

---
--- @param isNotGoingToMenu float
---
function onGameOverConfirm(isNotGoingToMenu)
	soundFadeOut("soundrain", 3)
end

function onSongStart()
	runTimer("thunderthing", getRandomInt(5, 15))
end