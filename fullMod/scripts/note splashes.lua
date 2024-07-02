local splashSize = {210, 210}
local splashScale = {1, 1}
local splashOffset = {-55, -55}
local splashAntialiasing = true

local splashCount = 0

function onCreate()
    get = getProperty
    getFromClass = getPropertyFromClass
    getFromGroup = getPropertyFromGroup
    set = setProperty
    setFromClass = setPropertyFromClass
    setFromGroup = setPropertyFromGroup

    string.startsWith = stringStartsWith
    string.endsWith = stringEndsWith

    if getFromClass("PlayState", "isPixelStage") then
        splashSize = {34, 34}
        splashScale = {6, 6}
        splashAntialiasing = false
    end
end

function onCreatePost()
    set("grpNoteSplashes.visible", false)
    spawnSplash(0, 0, 0)
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    if (getFromGroup("notes", id, "rating") ~= "sick") or (not getFromClass("ClientPrefs", "noteSplashes")) then return end

    spawnSplash(getFromGroup("playerStrums", noteData, "x") + splashOffset[1], getFromGroup("playerStrums", noteData, "y") + splashOffset[2], noteData)
end

function spawnSplash(x, y, noteData)
    splashCount = splashCount + 1

    local splashObj = "splash"..splashCount
    local assetModifier = getFromClass("PlayState", "isPixelStage") and "pixel" or "base"

    makeLuaSprite(splashObj, "", x, y)
    loadGraphic(splashObj, "foreverSplashes", splashSize[1], splashSize[2])
    addAnimation(splashObj, "splosh1", {
        (noteData * 2 + 1),
        8 + (noteData * 2 + 1),
        16 + (noteData * 2 + 1),
        24 + (noteData * 2 + 1),
        32 + (noteData * 2 + 1)
    }, 24, false)
    addAnimation(splashObj, "splosh2", {
        (noteData * 2),
        8 + (noteData * 2),
        16 + (noteData * 2),
        24 + (noteData * 2),
        32 + (noteData * 2)
    }, 24, false)
    set(splashObj..".alpha", 0.6)
    playAnim(splashObj, "splosh"..math.random(1, 2))
    setObjectCamera(splashObj, "hud")
    scaleObject(splashObj, splashScale[1], splashScale[2])
    updateHitbox(splashObj)
    set(splashObj..".antialiasing", splashAntialiasing and getFromClass("ClientPrefs", "globalAntialiasing") or false)
    addLuaSprite(splashObj, true)
    runTimer("splashTimer"..splashCount, (get(splashObj..".animation.curAnim.frames.length") / get(splashObj..".animation.curAnim.frameRate")) / playbackRate)
end

function onTimerCompleted(name)
    if string.startsWith(name, "splashTimer") then
        local countLol = name:gsub("splashTimer", "")
        removeLuaSprite("splash"..countLol, true)
    end
end