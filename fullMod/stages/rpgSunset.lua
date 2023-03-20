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
  if not stringStartsWith(dadName, 'pix_') then
	  scaleChar('dad', 0.6, 0.6)
  else
    scaleChar('dad', 4, 4)
  end
	scaleChar('gf', -6, 6)
	if not mustHitSection and not gfSection then
		setProperty('defaultCamZoom', 1)
  else
		setProperty('defaultCamZoom', 0.6)
	end
end

function scaleChar(char, x, y)
    x = x or 1
    y = y or x
    if not scaleChar_init then
      addHaxeLibrary('FunkinLua')
      addHaxeLibrary('Character')
      runHaxeCode([[
        function setProperty(variable:String, value:Dynamic):Bool
        {
          if(getProperty(variable, true) == null)
            return;
          var killMe:Array<String> = variable.split('.');
          if(killMe.length > 1) {
            FunkinLua.setVarInArray(FunkinLua.getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1], value);
            return true;
          }
          FunkinLua.setVarInArray(FunkinLua.getInstance(), variable, value);
          return true;
        }
        function getProperty(variable:String):Dynamic
        {
          var result:Dynamic = null;
          var killMe:Array<String> = variable.split('.');
          if(killMe.length > 1)
            result = FunkinLua.getVarInArray(FunkinLua.getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
          else
            result = FunkinLua.getVarInArray(FunkinLua.getInstance(), variable);
          return result;
        }
      ]])
      scaleChar_init = true
    end
    runHaxeCode([[
      var char:String = "]]..char:gsub('"', '\\"')..[[";
      var scale:Array<Float> = ]]..('[' .. table.concat({x, y}, ',') .. ']')..[[;
      
      var dummyChar = new Character(0, 0, getProperty(char + '.curCharacter'));
      var offsets:Map<String, Array<Dynamic>> = dummyChar.animOffsets;
      dummyChar.kill();
      dummyChar.destroy();
      
      for(offset in offsets)
      {
        offset[0] *= scale[0];
        offset[1] *= scale[1];
      }
      
      setProperty(char + '.animOffsets', offsets);
      setProperty(char + '.scale.x', scale[0]);
      setProperty(char + '.scale.y', scale[1]);
    ]])
  end