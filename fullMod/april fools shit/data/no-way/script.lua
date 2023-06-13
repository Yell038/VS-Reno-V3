function onEndSong()
	loadSong('this-is-so-amazing', 1)
	return Function_Stop
end

function onUpdate(elapsed)
	for i = 0, getProperty('opponentStrums.length')-1 do
        setPropertyFromGroup('opponentStrums', i, 'alpha', 0);
    end
end