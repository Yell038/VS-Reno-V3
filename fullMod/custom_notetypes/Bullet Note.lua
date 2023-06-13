function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Bullet Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'BULLETNOTE_assets'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'BULLETNOTE_splashes'); --Change splash texture

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
			
			end
		end
	end
	--debugPrint('Script started!')
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == "Bullet Note" then
		setProperty('health', getProperty('health') -0.5);
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == "Bullet Note" then
		-- characterPlayAnim('BF','dodge',true)
		triggerEvent('Play Animation','dodge','BF')
		cameraShake('game',0.01,0.1)
		playSound('shoot',1,'shootsnd')
		-- characterPlayAnim('GF','scared',true)
		-- triggerEvent('Play Animation','scared','GF')
	end
	if noteType == "Bullet Note" and noteData == 0 then
		-- characterPlayAnim('Dad','shootLEFT',true)
		triggerEvent('Play Animation','shootLEFT','Dad')
	end
	
	if noteType == "Bullet Note" and noteData == 1 then
		-- characterPlayAnim('Dad','shootDOWN',true)
		triggerEvent('Play Animation','shootDOWN','Dad')
	end
	
	if noteType == "Bullet Note" and noteData == 2 then
		-- characterPlayAnim('Dad','shootUP',true)
		triggerEvent('Play Animation','shootUP','Dad')
	end
	
	if noteType == "Bullet Note" and noteData == 3 then
		-- characterPlayAnim('Dad','shootRIGHT',true)
		triggerEvent('Play Animation','shootRIGHT','Dad')
	end

	if noteType == "Bullet Note" and not stringStartsWith(boyfriendName, 'nema') then
		if getPropertyFromGroup('notes', id, 'rating') == 'good' and getPropertyFromGroup('notes', id, 'rating') == 'sick' then
			setProperty('health', getProperty('health') -0.1);
		else if getPropertyFromGroup('notes', id, 'rating') == 'bad' then
			setProperty('health', getProperty('health') -0.25);
		else if getPropertyFromGroup('notes', id, 'rating') == 'shit' then
			setProperty('health', getProperty('health') -0.5);
		end
		end
		end
	end
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
	if noteType == "Bullet Note" then
		-- characterPlayAnim('BF','dodge',true)
		triggerEvent('Play Animation','dodge','BF')
		cameraShake('game',0.01,0.1)
		playSound('shoot',1,'shootsnd')
		-- characterPlayAnim('GF','scared',true)
		-- triggerEvent('Play Animation','scared','GF')
		if dadName == 'nema' then
			setProperty('health', getProperty('health') -0.1);
		end
	end
	if noteType == "Bullet Note" and noteData == 0 then
		-- characterPlayAnim('Dad','shootLEFT',true)
		triggerEvent('Play Animation','shootLEFT','Dad')
	end
	
	if noteType == "Bullet Note" and noteData == 1 then
		-- characterPlayAnim('Dad','shootDOWN',true)
		triggerEvent('Play Animation','shootDOWN','Dad')
	end
	
	if noteType == "Bullet Note" and noteData == 2 then
		-- characterPlayAnim('Dad','shootUP',true)
		triggerEvent('Play Animation','shootUP','Dad')
	end
	
	if noteType == "Bullet Note" and noteData == 3 then
		-- characterPlayAnim('Dad','shootRIGHT',true)
		triggerEvent('Play Animation','shootRIGHT','Dad')
	end
end