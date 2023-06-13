function onEvent(name,value1,value2)
    if name == "step zoom" then
        joe = tonumber(value1)
	end
end

function onStepHit()
	if(curStep % joe == 0) then
		triggerEvent("Add Camera Zoom");
	end
end