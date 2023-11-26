function onStepHit()
    if curStep >= 256 and curStep <= 512 then
	    if(curStep % 4 == 0) then
		    triggerEvent("Add Camera Zoom", 0.05)
	    end
    end
	if curStep >= 768 and curStep <= 1024 then
	    if(curStep % 4 == 0) then
		    triggerEvent("Add Camera Zoom", 0.05)
	    end
    end
	if curStep >= 1280 and curStep <= 1536 then
	    if(curStep % 4 == 0) then
		    triggerEvent("Add Camera Zoom", 0.05)
	    end
    end
end