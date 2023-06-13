function onCreate()
	creditname = getTextFromFile('data/'..songPath..'/credits.txt')
	makeLuaText('credit', 'Composed By '..creditname, getPropertyFromClass('flixel.FlxG','width'), 0, 697)
	setTextBorder('credit', 1, '000000')
	addLuaText('credit')
	setObjectCamera('credit', 'hud')
end