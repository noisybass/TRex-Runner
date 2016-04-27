local anim8 = require 'anim8'

local x, y = 400, 300

function love.load()
	image = love.graphics.newImage('media/trex_run.png')

	local grid = anim8.newGrid(128, 128, 256, 128)

	animation = anim8.newAnimation(grid('1-2', 1), 0.1)
end

function love.update(dt)
	if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
		x = x - 100 * dt
	end
	if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
		x = x + 100 * dt
	end
	if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
		y = y - 100 * dt
	end
	if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
		y = y + 100 * dt
	end

	--if love.mouse.isDown(1) then
	--	animation: pause()
	--elseif love.mouse.isDown(2) then
	--	animation: resume()
	--else
		animation: update(dt)
	--end
end

function love.draw()
	animation: draw(image, x, y)
end

function love.mousepressed(x, y, button, istouch)
	if button == 1 then
		animation: flipH()
	end
end