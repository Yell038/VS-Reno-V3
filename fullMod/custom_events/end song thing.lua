---
--- @param eventName string
--- @param value1 string
--- @param value2 string
---
function onEvent(eventName, value1, value2)
    if eventName == 'end song thing' then
        cameraFade("game", "000000", 0.0, false)
    end
end