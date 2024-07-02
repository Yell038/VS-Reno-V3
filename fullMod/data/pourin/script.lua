function onCreate()
    makeLuaSprite("blackback", '', 0, 0)
    makeGraphic("blackback", 3000, 2000, '000000')
    setScrollFactor("blackback", 0.0, 0.0)
    screenCenter("blackback", 'xy')
    setProperty("blackback.alpha", 0)

    --HudAssets = {'healthBarBG','healthBar','scoreTxt','iconP1','iconP2','timeBar','timeBarBG','timeTxt'}
end

function onCreatePost()
    setProperty("healthBarBG.alpha", 0)
    setProperty("healthBar.alpha", 0)
    setProperty("iconP1.alpha", 0)
    setProperty("iconP2.alpha", 0)
    setProperty("scoreTxt.alpha", 0)

    setTextString("JukeBoxSubText", "pourin'")
    setTextString("centerMark", "- pourin' -")

    initLuaShader('rain')

    
	makeLuaSprite('rainshader', '', 0, 0);
	setSpriteShader('rainshader','rain')
    addHaxeLibrary("ShaderFilter", "openfl.filters")
	runHaxeCode([[
		trace(ShaderFilter);
		game.camGame.setFilters([new ShaderFilter(game.getLuaObject("rainshader").shader)]);
	]])
end

function onStepHit()
    if curStep == 128 then
        setProperty("healthBarBG.alpha", 1)
        setProperty("healthBar.alpha", 1)
        setProperty("iconP1.alpha", 1)
        setProperty("iconP2.alpha", 1)
        setProperty("scoreTxt.alpha", 1)
    end
    if curStep == 768 then
        addLuaSprite("blackback", false)
        doTweenAlpha("glassofmilk", "blackback", 0.5, 0.5, "linear")
    end
    if curStep == 784 then
        removeLuaSprite("blackback", true)
        setProperty("blackback.alpha", 0)
    end
end

function onCountdownStarted()
    cameraFlash("game", "000000", 13)
end