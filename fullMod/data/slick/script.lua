function onCreate()
	addCharacterToList('bf-night', 'boyfriend')
	addCharacterToList('renoNight', 'dad')
	addCharacterToList('gf-night', 'gf')
	precacheImage('street/night/sky')
	precacheImage('street/night/skyline')
	precacheImage('street/night/street')
	precacheImage('street/night/glow')
end

function onStepHit()
	if curStep == 1296 then
		removeLuaScript('stages/renoback')
		removeLuaSprite('frontBopper')
		triggerEvent("flash", "ffffff", "1")
		triggerEvent("Change Character", "dad", "renoNight")
		triggerEvent("Change Character", "gf", "emily-night")
		triggerEvent("Change Character", "bf", "bf-renoskin-night")
		addLuaScript('stages/streetnight')
	end
end