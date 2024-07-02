function onCreate()
    get = getProperty
    getFromClass = getPropertyFromClass
    getFromGroup = getPropertyFromGroup
    set = setProperty
    setFromClass = setPropertyFromClass
    setFromGroup = setPropertyFromGroup
end

function onCreatePost()
	creditname = getTextFromFile('data/'..songPath..'/credits.txt')
	makeLuaText('credit', 'Composed By '..creditname, getPropertyFromClass('flixel.FlxG','width'), 0.5, screenHeight - 20)
	setTextAlignment('credit', 'left')
	setTextBorder('credit', 1, '000000')
	addLuaText('credit')
	setObjectCamera('credit', 'other')
	setProperty("credit.alpha", 0.5)

	set("credit.antialiasing", getFromClass("ClientPrefs", "globalAntialiasing"))
end