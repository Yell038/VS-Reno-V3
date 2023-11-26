function onCreate()
	-- Sprites
	if not lowQuality then
		makeAnimatedLuaSprite('halloweenBG', 'spooky2/halloween2_bg', -200, -100);
		addAnimationByPrefix('halloweenBG', 'idle', 'halloweem bg0', 24, false);
		addAnimationByPrefix('halloweenBG', 'thunder', 'halloweem bg lightning strike', 24, false);
	else
		makeLuaSprite('halloweenBG', 'spooky2/halloween2_bg_low', -200, -100);
	end
	
	makeLuaSprite('halloweenWhite', nil, 0, 0)
	setScrollFactor('halloweenWhite', 0, 0)
	makeGraphic('halloweenWhite', screenWidth * 3, screenHeight * 3, 'FFFFFF')
	setProperty('halloweenWhite.alpha', 0)
	setBlendMode('halloweenWhite', 'add')
	
	-- Adding
	addLuaSprite('halloweenBG', false);
	addLuaSprite('halloweenWhite', true);
	
	-- Precaching
	precacheSound('thunder_1')
	precacheSound('thunder_2')
end

local lightningStrikeBeat = 0
local lightningOffset = 8
function onBeatHit()
	if getRandomBool(10) and curBeat > lightningStrikeBeat + lightningOffset then
		lightningStrikeShit()
	end
end

function lightningStrikeShit()
	lightningStrikeBeat = curBeat
	lightningOffset = getRandomInt(8, 24)
	if not lowQuality then
		objectPlayAnimation('halloweenBG', 'thunder')
	end
	soundName = string.format('thunder_%i', getRandomInt(1, 2));
	playSound(soundName, 1, 'thundah');
	characterPlayAnim('gf', 'scared');
	characterPlayAnim('boyfriend', 'scared');
	if cameraZoomOnBeat then
		setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.015)
		setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.03)
		
		if not getProperty('camZooming') then
			doTweenZoom('cG', 'camGame', getProperty('defaultCamZoom'), 0.5, 'linear')
			doTweenZoom('cH', 'camHUD', 1, 0.5, 'linear')
		end
	end
	if flashingLights then
		setProperty('halloweenWhite.alpha', 0.4)
		doTweenAlpha('hWA', 'halloweenWhite', 0.5, 0.075, 'linear')
	end
end

function onTweenCompleted(t)
	if t == 'hWA' then
		doTweenAlpha('hWA0', 'halloweenWhite', 0, 0.25, 'linear')
	end
end