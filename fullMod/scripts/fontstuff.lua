function onUpdate()
    setTextFont('scoreTxt', 'LEMONMILK-Medium.otf')
    setTextColor('scoreTxt', 'ffce99')
    setTextFont('timeTxt', 'LEMONMILK-Medium.otf')
    setTextString('botplayTxt', 'showcasing\n(or you suck)')
    setTextFont('botplayTxt', 'LEMONMILK-Medium.otf')

    if keyboardJustPressed('SIX') then
        endSong()
    end
end

function onCreatePost()
    if downscroll then
        setProperty('timeTxt.y', getProperty('timeTxt.y') - 35)
        setProperty('botplayTxt.y', getProperty('botplayTxt.y') - 360)
    else
        setProperty('timeTxt.y', getProperty('timeTxt.y') - -35)
        setProperty('botplayTxt.y', getProperty('botplayTxt.y') - -360)
    end
end