function onCreate()
    precacheImage('characters/reno')
    addLuaScript('data/epic-ending-remix/reno')
end

function onUpdate()
    for i = 0, getProperty('opponentStrums.length')-1 do
        setPropertyFromGroup('opponentStrums', i, 'alpha', 0);
    end
end

function onStepHit()
    if curStep > 144 then
        doTweenAlpha('hudFunne', 'camHUD', 1, 0.2, 'linear')
    end
end

function onSongStart()
    doTweenAlpha('hudFunne', 'camHUD', 0, 0.4, 'linear')
	removeLuaScript('characters/bf')
end

local allowCountdown = false
function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
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