function onEvent(name, value1, value2)
	if name == "Image Flash" then
		makeLuaSprite('image', value1, 0, 0);
		addLuaSprite('image', true);
		setObjectCamera('image', 'other');
		doTweenAlpha('byebye', 'image', 0, value2, 'linear');
	end
end

function onTweenCompleted(tag)
	if tag == 'byebye' then
		removeLuaSprite('image', true);
	end
end