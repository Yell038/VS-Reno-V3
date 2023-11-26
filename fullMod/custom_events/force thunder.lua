function onCreate()
	--preload the event
	addLuaScript('custom_events/required')
end

function onEvent(name)
	if name == "force thunder" then
		if curStage == 'roadRain' then
			playSound("thunder", 1)
			setProperty("flashthing.alpha", 0.3)
			doTweenAlpha("frer", "flashthing", 0, 0.5, "linear")
		end
	end
end