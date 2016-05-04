local anim8 = require 'anim8'
local bump = require 'bump'

local cols_len = 0 -- how many collisions are happening

-- World creation
local world = bump.newWorld()


-- Trex
local trex = {
	x = 400,
	y = 200,
	w = 76,
	h = 76,
	speed = 150
}

function updateTrex(dt)
	trex.run: update(dt)

	local speed = trex.speed

	local dx, dy = 0, 0
	if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
		dx = -speed * dt
	elseif love.keyboard.isDown("right") or love.keyboard.isDown("d") then
		dx = speed * dt
	end
	if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
		dy = -speed * dt
	elseif love.keyboard.isDown("down") or love.keyboard.isDown("s") then
		dy = speed * dt
	end

	if dx ~= 0 or dy ~= 0 then
		local cols
		trex.x, trex.y, cols, cols_len = world: move(trex, trex.x + dx, trex.y + dy)
	end
end

function drawTrex()
	drawBox(trex, 0, 255, 0)
	trex.run: draw(image, trex.x, trex.y)
end

-- Blocks
local blocks = {}

function addBlock(x, y, w, h)
	local block = { x = x, y = y, w = w, h = h }
	blocks[#blocks + 1] = block
	world: add(block, x, y, w, h)
end

function drawBlocks()
	for _, block in ipairs(blocks) do
		drawBox(block, 0, 0, 255)
	end
end


------------------------------------------------

function love.load()

	image = love.graphics.newImage('media/trex_run.png')

	local grid = anim8.newGrid(76, 76, 152, 76)

	trex.run = anim8.newAnimation(grid('1-2', 1), 0.1)

	world: add(trex, trex.x, trex.y, trex.w, trex.h)

	addBlock(0, 0, 800, 32)
	addBlock(0, 32, 32, 600 - 32*2)
	addBlock(800 - 32, 32, 32, 600 - 32*2)
	addBlock(0, 600-32, 800, 32)

end

function love.update(dt)

	updateTrex(dt)

end

function love.draw()

	drawBlocks()
	drawTrex()

end

function love.keypressed(key)
    if key == "escape" then
       love.event.quit()
    end
end

function drawBox(box, r, g, b)
	love.graphics.setColor(r, g, b, 70)
	love.graphics.rectangle("fill", box.x, box.y, box.w, box.h)
	love.graphics.setColor(r, g, b)
	love.graphics.rectangle("line", box.x, box.y, box.w, box.h)
end



--[[function love.mousepressed(x, y, button, istouch)
	local x, y = body: getLinearVelocity()
	if button == 1 and y == 0 then
		animation: flipH()
		body: applyLinearImpulse(0,-2000)
	end
end]]