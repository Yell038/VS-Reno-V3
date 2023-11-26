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
		triggerEvent("Change Character", "gf", "gf-night")
		triggerEvent("Change Character", "bf", "bf-renoskin-night")
		addLuaScript('stages/streetnight')
	end
end

local allowCountdown = false
function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		startVideo(cut1);
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue', 'breakfast');
	end
end

-- Dialogue (When a dialogue is finished, it calls startCountdown again)
function onNextDialogue(count)
	-- triggered when the next dialogue line starts, 'line' starts with 1
end

function onSkipDialogue(count)
	-- triggered when you press Enter and skip a dialogue line that was still being typed, dialogue line starts with 1
end