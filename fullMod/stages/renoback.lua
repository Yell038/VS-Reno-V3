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
		playAnim('leftBopper', 'idle');
		playAnim('rightBopper', 'idle');
		playAnim('frontBopper', 'idle');
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

-------------------- DO NOT TOUCH!! --------------------

--[[ perspective sprite ]]

local vanish_offset = {x = 0, y = 0}
local sprites = {}

function setPerspective(tag, depth)
	depth = tonumber(depth) or 1
	
	if sprites[tag] then
		sprites[tag].depth = depth
	else
		sprites[tag] = {
			x = getProperty(tag .. ".x"),
			y = getProperty(tag .. ".y"),
			width = getProperty(tag .. ".width"),
			height = getProperty(tag .. ".height"),
			scale = {x = getProperty(tag .. ".scale.x"), y = getProperty(tag .. ".scale.y")},
			depth = depth
		}

		initLuaShader("perspective")
		setSpriteShader(tag, "perspective")
		setShaderFloatArray(tag, "u_top", {0, 1})
		setShaderFloat(tag, "u_depth", depth)
	end
end

function removePerspective(tag)
	local sprite = sprites[tag]
	if sprite then
		scaleObject(tag, sprite.scale.x, sprite.scale.y, true)
		setProperty(tag .. ".x", sprite.x)
		setProperty(tag .. ".y", sprite.y)
		
		removeSpriteShader(tag)
		
		sprites[tag] = nil
	end
end

function setVanishOffset(x, y)
	if x then vanish_offset.x = tonumber(x) or 0 end
	if y then vanish_offset.y = tonumber(y) or 0 end
end

--

for _, func in pairs({"max"}) do _G[func] = math[func] end

function onUpdatePost()
	local cam = {x = getProperty("camFollowPos.x") + vanish_offset.x, y = getProperty("camFollowPos.y") + vanish_offset.y}

	for tag, sprite in pairs(sprites) do
		local vanish = {x = (cam.x - sprite.x) / sprite.width, y = 1 - (cam.y - sprite.y) / sprite.height}
		local top = {sprite.depth * vanish.x, sprite.depth * (vanish.x - 1) + 1}
		
		if top[2] > 1 then
			scaleObject(tag, sprite.scale.x * (1 + sprite.depth * (vanish.x - 1)), sprite.scale.y * (sprite.depth * vanish.y), true)
		elseif top[1] < 0 then
			scaleObject(tag, sprite.scale.x * (1 - sprite.depth * (vanish.x)), sprite.scale.y * (sprite.depth * vanish.y), true)
			setProperty(tag .. ".x", sprite.x + sprite.width * sprite.depth * vanish.x)
		else
			scaleObject(tag, sprite.scale.x, sprite.scale.y * (sprite.depth * vanish.y), true)
		end
		
		setProperty(tag .. ".y", sprite.y + sprite.height * (1 - sprite.depth * max(vanish.y, 0)))
		
		setShaderFloatArray(tag, "u_top", top)
	end
end