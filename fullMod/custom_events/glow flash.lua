function onCreatePost()
    makeLuaSprite('lightflash', 'street/lightflash');
	setScrollFactor('lightflash', 1, 1);
	setObjectCamera('lightflash', 'other')
    setProperty("lightflash.alpha", 0)
	addLuaSprite('lightflash', true);
	setBlendMode("lightflash", 'add')

	makeLuaSprite('flare', 'street/flare');
	setScrollFactor('flare', 0.4, 0.4);
	setObjectCamera('flare', 'game')
	setProperty("flare.alpha", 0)
	addLuaSprite('flare', true);

	setBlendMode("flare", 'add')
end

---
--- @param eventName string
--- @param value1 string
--- @param value2 string
--- @param strumTime float
---
function onEvent(eventName, value1, value2)
    if eventName == 'glow flash' then
        doTweenAlpha("asd", "lightflash", 0.5, 0.2, "circOut")
		doTweenAlpha("asdf", "flare", 0.5, 0.2, "circOut")
    end
end

function onTweenCompleted(tag)
	if tag == "asd" then
		doTweenAlpha("fgh", "lightflash", 0, 5, "linear")
	end
	if tag == "asdf" then
		doTweenAlpha("fgha", "flare", 0, 2, "linear")
	end
end