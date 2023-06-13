function onUpdate(elapsed)
    setTextFont('scoreTxt', 'LEMONMILK-Medium.otf')
    setTextFont('timeTxt', 'LEMONMILK-Medium.otf')
    setTextString('botplayTxt', 'showcasing\n(or you suck)')
    setTextFont('botplayTxt', 'LEMONMILK-Medium.otf')

    if stringStartsWith(dadName, 'reno') then
        setTextColor('scoreTxt', '2d8800')
        setTextColor('score', '2d8800')
    else if stringStartsWith(dadName, 'jaq') then
        setTextColor('scoreTxt', 'd45eff')
        setTextColor('score', 'd45eff')
    else if stringStartsWith(dadName, 'nema') then
        setTextColor('scoreTxt', 'ffce99')
        setTextColor('score', 'ffce99')
        end
    end
    end

    if keyboardJustPressed('SIX') then
        endSong()
    end

    if isStoryMode then
        setProperty('scoreTxt.visible', false)
    end
end

function onCreatePost()
    if isStoryMode then
        makeLuaText('score', 'Score: 0', 200, 550, getProperty('healthBarBG.y') +  30)
        setTextFont('score', 'LEMONMILK-Medium.otf')
        addLuaText('score')
    end
    setProperty('scoreTxt.y', getProperty('scoreTxt.y') - 7)
    setProperty('camHUD.alpha', 0)
    if downscroll then
        setProperty('timeTxt.y', getProperty('timeTxt.y') - 35)
        setProperty('botplayTxt.y', getProperty('botplayTxt.y') - 360)
    else
        setProperty('timeTxt.y', getProperty('timeTxt.y') - -35)
        setProperty('botplayTxt.y', getProperty('botplayTxt.y') - -360)
    end
end

function onCountdownStarted()
    doTweenAlpha('some random', 'camHUD', 1, 1, 'linear')
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    setTextString('score', 'Score: '.. getProperty('songScore'))
end

function noteMiss(...)
	setTextString('score', 'Score: '.. getProperty('songScore'))
end