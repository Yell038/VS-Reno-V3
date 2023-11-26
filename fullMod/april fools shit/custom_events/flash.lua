function onEvent(name, value1, value2)
    if name == 'flash' and flashingLights then
        cameraFlash(game, value1, value2)
    end
end