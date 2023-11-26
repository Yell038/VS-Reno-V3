function onCountdownTick(swagCounter)
    if swagCounter == 0 then
        playAnim('boyfriend', 'three', true)
    end
    if swagCounter == 1 then
        playAnim('boyfriend', 'two', true)
    end
    if swagCounter == 2 then
        playAnim('boyfriend', 'one', true)
    end
    if swagCounter == 3 then
        playAnim('gf', 'cheer', true)
        playAnim('boyfriend', 'hey', true)
    end
end

function onCreatePost()
    playAnim('boyfriend', 'three', true)
end