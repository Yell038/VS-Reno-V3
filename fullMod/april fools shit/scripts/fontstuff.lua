function onUpdate(elapsed)
    setTextFont('scoreTxt', 'LEMONMILK-Medium.otf')
    setTextFont('timeTxt', 'LEMONMILK-Medium.otf')
    setTextString('botplayTxt', 'showcasing\n(or you suck)')
    setTextFont('botplayTxt', 'LEMONMILK-Medium.otf')

    if stringStartsWith(dadName, 'reno') then
        setTextColor('scoreTxt', '2d8800')
    else if stringStartsWith(dadName, 'jaq') then
        setTextColor('scoreTxt', 'd45eff')
    else if stringStartsWith(dadName, 'nema') then
        setTextColor('scoreTxt', 'ffce99')
        end
    end
    end

    if keyboardJustPressed('SIX') then
        endSong()
    end
end

function onCreatePost()
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