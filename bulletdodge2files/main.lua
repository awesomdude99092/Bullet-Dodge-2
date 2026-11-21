opened = false
introflag = false
pabcflag = false
r,g,b = 0,0,0
r2,g2,b2 = 0,0,0
windoww = 0
windowh = 0
gamestate = "intro"

-----------------------------------------------------------------
function savegame()
        local data = {}
        local sdata = serialize(data)
        love.filesystem.write("BulletDodgeData.txt", sdata)
end
-----------------------------------------------------------------
function boolToStr(bool)
	if bool == false then
		return "false"
	elseif bool == true then
		return "true"
	end
end
-----------------------------------------------------------------

function center(x, w)
    return x - (w / 2)
end
-----------------------------------------------------------------
function serialize(tbl)
        local result = "return {"
        for key, value in pairs(tbl) do
        	if type(value) == "string" then
                	result = result .. key .. ' = "' .. value .. '",'
        	elseif type(value) == "number" or type(value) == "boolean" then
                	result = result .. key .. ' = ' .. tostring(value) .. ','
        	end
        end
        result = result .. "}"
        return result
end
-----------------------------------------------------------------
function love.load()
	love.window.setMode(0, 0, {fullscreen = true})
	windoww,windowh = love.graphics.getDimensions()
end
-----------------------------------------------------------------
--timers
local timer = 0
local timer2 = 0
-----------------------------------------------------------------
function love.update(dt)
	if opened == false then
		timer = timer + dt
		if timer >= 2 then
			gamestate = "intro"
			opened = true

		end
	end
	if gamestate == "intro" then
		timer = timer + dt
		timer2 = timer2 + dt
		if timer2 >= 0.05 and r <= 1 then
			r,g,b = r + 0.01, g + 0.01, b + 0.01 
			timer2 = 0
		end
		if timer >= 6 then
			pabcflag = true
			if timer2 >= 0.1 and r2 <= 0.6 then
				r2,g2,b2 = r2 + 0.01, g2 + 0.01, b2 + 0.01 
				timer2 = 0
			end
		end
	end
end

function love.keypressed(key)
	if key == "escape" then 
		savegame()
		love.event.quit()
	end
	if pabcflag == true then
		gamestate = "home"
	end
end


function love.draw()
	love.graphics.setColor(1,1,1)
	local font = love.graphics.newFont(10)
	love.graphics.setFont(font)
	--love.graphics.print(gamestate, 100, 80)
	--love.graphics.print(r2, 100, 100)
	--love.graphics.print(g2, 100, 120)
	--love.graphics.print(b2, 100, 140)
	--love.graphics.print(timer2, 100, 160)
	--love.graphics.print(timer, 100, 200)
	--love.graphics.print(boolToStr(pabcflag), 100, 180)
	if gamestate == "intro" then
		local font = love.graphics.newFont(150)
		love.graphics.setFont(font)
		love.graphics.setColor(r,g,b)
		local titlew = font:getWidth("Bullet Dodge 2")
		local titleh = font:getHeight()
		love.graphics.print("Bullet Dodge 2", center((windoww / 2), titlew), center((windowh / 2), titleh)) 
		love.graphics.setColor(1,1,1)
		if pabcflag == true then
			local font = love.graphics.newFont(20)
			love.graphics.setFont(font)
			love.graphics.setColor(r2,g2,b2)
			local titlew = font:getWidth("push any button to continue")
			local titleh = font:getHeight()
			love.graphics.print("push any button to continue", center((windoww / 2), titlew), center((windowh / 2) + 100, titleh)) 
			love.graphics.setColor(1,1,1)
		end
	end
	if gamestate == "home" then
		local font = love.graphics.newFont(100)
		love.graphics.setFont(font)
		local titlew = font:getWidth("Bullet Dodge 2")
		local titleh = font:getHeight()
		love.graphics.print("Bullet Dodge", center((windoww / 2), titlew), center((windowh / 2) - 300, titleh))
		love.graphics.rectangle("fill", 50, windowh - 150, 300, 100)
	end

end