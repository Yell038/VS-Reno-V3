local daPixelZoom = 6
function onCreate()
	addLuaScript('scalecharacter')
  removeLuaScript('scripts/camfunnycringe')

	setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-pixel-dead')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx-pixel')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameOver-pixel')
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd-pixel')
	
	makeLuaSprite('bgSky', 'rpgSunsetStage/sunset', -700, -500)
	setScrollFactor('bgSky', 0.1)
	setProperty('bgSky.antialiasing', false)

	makeLuaSprite('mountB', 'rpgSunsetStage/mountainback', -700, -200)
	setScrollFactor('mountB', 0.5)
	setProperty('mountB.antialiasing', false)

	makeLuaSprite('mountF', 'rpgSunsetStage/mountainfront', -700, -200)
	setScrollFactor('mountF', 0.6)
	setProperty('mountF.antialiasing', false)

  makeLuaSprite('haha', 'rpgSunsetStage/jaqmountain', -600)
  setScrollFactor('haha', 0.7, 0.7)
	setProperty('haha.antialiasing', false)
	
	makeLuaSprite('grassFront', 'rpgSunsetStage/grassfront', -600, -300)
	setScrollFactor('grassFront', 0.95, 0.95)
	setProperty('grassFront.antialiasing', false)

    makeLuaSprite('grassBack', 'rpgSunsetStage/grassback', -600, -300)
	setScrollFactor('grassBack', 0.8, 0.95)
	setProperty('grassBack.antialiasing', false)

	makeLuaSprite('pillar', 'rpgSunsetStage/pillar', -600, -300)
	setScrollFactor('pillar', 0.95, 0.95)
	setProperty('pillar.antialiasing', false)

	makeLuaSprite('glow', 'street/glow');
	setScrollFactor('glow', 1, 1);
	setObjectCamera('glow', 'other')
	
	widShit = getProperty('bgSky.width') * 15
  otherwidShit = getProperty('bgSky.width') * 12
	
	setGraphicSize('bgSky', widShit)
	setGraphicSize('mountB', widShit)
	setGraphicSize('mountF', widShit)
	setGraphicSize('grassBack', widShit)
  setGraphicSize('grassFront', widShit)
	setGraphicSize('pillar', widShit)
  setGraphicSize('haha', otherwidShit)
	
	updateHitbox('bgSky')
  updateHitbox('haha')
	updateHitbox('grassBack')
  updateHitbox('grassFront')
	updateHitbox('pillar')
	updateHitbox('mountB')
	updateHitbox('mountF')
	
	
	addLuaSprite('bgSky', false)
	addLuaSprite('mountB', false)
	addLuaSprite('mountF', false)
  addLuaSprite('haha', false)
	addLuaSprite('grassBack', false)
	addLuaSprite('pillar', false)
  addLuaSprite('grassFront', false)
	addLuaSprite('glow', true)

  -- char stuff
  setObjectOrder('dadGroup', 4)
end

function onUpdate()
  doTweenY('funnily', 'bgSky', 0.01, songLength / 1000, 'linear')
  doTweenAlpha('funnilyer', 'glow', 0, songLength / 1000, 'linear')
  setScrollFactor('dad', 0.7, 0.7)
	if not mustHitSection and not gfSection then
		setProperty('defaultCamZoom', 1)
  else
		setProperty('defaultCamZoom', 0.6)
	end
end