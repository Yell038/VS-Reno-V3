function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'customSingRight' then

			setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', false); --disable the boyfriend or dad miss animations
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true); --disable the boyfriend or dad animations on this note type
		end
	end
end
