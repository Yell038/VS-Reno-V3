function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'customSingLeftDouble' and getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
			-- Literally damn nothing
		end
	end
end
		