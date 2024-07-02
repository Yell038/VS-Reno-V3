local offset = 3000


function onUpdate()
    if stringStartsWith(dadName, 'reno') then
        setTextColor('scoreTxt', '00ea5a')
    else if stringStartsWith(dadName, 'jaq') then
        setTextColor('scoreTxt', 'd45eff')
    else if stringStartsWith(dadName, 'nema') then
        setTextColor('scoreTxt', 'ffce99')
        end
    end
    end

    if keyboardJustPressed('SIX') then
        endSong()
    end

    if isStoryMode then
        setTextString('scoreTxt', 'Score: '..score)
    end

    for index = 0,getProperty('unspawnNotes')-1 do
        setPropertyFromGroup('unspawnNotes', index, 'strumTime', getPropertyFromGroup('unspawnNotes', index, 'strumTime') + offset)
    end
end

function onCreate()
    get = getProperty
    getFromClass = getPropertyFromClass
    getFromGroup = getPropertyFromGroup
    set = setProperty
    setFromClass = setPropertyFromClass
    setFromGroup = setPropertyFromGroup
end

function onCreatePost()
    setTextFont('scoreTxt', 'LEMONMILK-Medium.otf')
    setTextString('botplayTxt', 'showcasing\n(or you suck)')
    setTextFont('botplayTxt', 'LEMONMILK-Medium.otf')

    set("scoreTxt.antialiasing", getFromClass("ClientPrefs", "globalAntialiasing"))

    setProperty('scoreTxt.y', getProperty('scoreTxt.y') - 7)
    if downscroll then
        setProperty('botplayTxt.y', getProperty('botplayTxt.y') - 360)
    else
        setProperty('botplayTxt.y', getProperty('botplayTxt.y') - -360)
    end

    local hideList = {"timeBarBG", "timeBar", "timeTxt"}
    for i = 1, #hideList do
        set(hideList[i]..".visible", false)
    end

    makeLuaText("centerMark", "- "..songName.." -", 0, 0, (downscroll and screenHeight - 40 or 10))
    setTextSize("centerMark", 24)
    setTextBorder("centerMark", 2, "000000")
    screenCenter("centerMark", "X")
    setObjectCamera("centerMark", "other")
    setProperty("centerMark.antialiasing", getPropertyFromClass("ClientPrefs", "globalAntialiasing"))
    addLuaText("centerMark")
    setProperty("centerMark.alpha", 0)

    --local badabingbadaboom = getPropertyFromClass("Note", "strumTime")
    --badabingbadaboom = badabingbadaboom + 500

    if not stringStartsWith("version", "0.6") then
        removeLuaScript("note splashes")
    end
end

---
--- @param tag string
--- @param loops integer
--- @param loopsLeft integer
---
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'JukeBoxWait' then
        removeSpriteShader("centerMark")
        doTweenAlpha("yeet", "centerMark", 0.5, 1, "linear")
    end
end