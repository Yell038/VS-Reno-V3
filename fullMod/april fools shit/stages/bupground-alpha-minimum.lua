function onCreatePost()
	makeLuaSprite('normalBG','',-500,-720)
	makeGraphic('normalBG',1280*3,720*3,'0xFFFFFFFF')
	addLuaSprite('normalBG')
	
	makeAStaticSpr('sky', 'bgs/alpha/bupground/bup sky', -2438, -1224, 0.75, 1.1, 0.9)
	makeAStaticSpr('grass', 'bgs/alpha/bupground/bup grass (please touch it)', -1689, 242, 0.75, 0.75, 0.9)
	makeAStaticSpr('clouds', 'bgs/alpha/bupground/bup cloud', 438, -760, 0.5, 1.07, 0.9)
end

function makeAStaticSpr(name, path, posx, posy, scale, sfx, sfy)
	makeLuaSprite(name, path, posx, posy)
	setProperty(name .. '.scale.x', scale)
	setProperty(name .. '.scale.y', scale)
	setProperty(name .. '.scrollFactor.x', sfx)
	setProperty(name .. '.scrollFactor.y', sfy)
	setProperty(name .. '.active', false)
	setProperty(name .. '.antialiasing', true)
	addLuaSprite(name, false)
end

---
--- @param elapsed float
---
function onUpdate(elapsed)
	if mustHitSection then
		doTweenY("dad", "dad.scale", 5, 0.2, "cubeOut")
		doTweenY("boyfriend", "boyfriend.scale", 1, 0.5, "cubeOut")
	else
		doTweenY("dad", "dad.scale", 0.8, 0.5, "cubeOut")
		doTweenY("boyfriend", "boyfriend.scale", 5, 0.2, "cubeOut")
	end
end