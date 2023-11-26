function onCreate()
  --background
  makeLuaSprite("sky", "nemabglazy/sky", -300, -400)
  setScrollFactor("sky", 0.6, 0.6)

  makeLuaSprite("bg", "nemabglazy/room", -300, -400)
  setScrollFactor("bg", 0.95, 0.95)


  makeLuaSprite("bed", "nemabglazy/bed", -300, -400)
  setScrollFactor("bed", 1.1, 1.1)
  setScrollFactor("boyfriendGroup", 1.1, 1.1)

  addLuaSprite('sky',false)
  addLuaSprite('bg',false)
  addLuaSprite('bed',false)

  if not middlescroll then
    makeLuaText("funnynote", "YOUR NOTES ARE HERE", 0, 175, 500)
    setTextSize("funnynote", 24)
    setProperty("funnynote.antialiasing", getPropertyFromClass("ClientPrefs", "globalAntialiasing"))
    setObjectCamera("funnynote", "hud")
    addLuaText("funnynote")
  end
end
function onCreatePost()
  if not middlescroll then
    for strums = 0,4 do
      setPropertyFromGroup('playerStrums', strums,'x',92 + (112 * strums))
      setPropertyFromGroup('opponentStrums', strums,'x',732 + (112 * strums))
    end
  end

  local bfflip = boyfriendName..'-flip'
  local dadflip = dadName..'-flip'

  if checkFileExists("characters/"..bfflip..".json") then
    triggerEvent("Change Character", 'bf', bfflip)
  end
  if checkFileExists("characters/"..dadflip..".json") then
    triggerEvent("Change Character", 'dad', dadflip)
  end
end

function onSongStart()
  doTweenAlpha("asdf1234haha", "funnynote", 0, 5, "linear")
end