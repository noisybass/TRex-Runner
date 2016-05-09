local anim8 = require 'anim8'
local bump = require 'bump'

-- World creation
local world = bump.newWorld()


-- Trex
local trex = {
	x = 400,
	y = 200,
	w = 76,
	h = 76,
	vx = 150,
	vy = 600,
	gravity = 300,
	onGround = false,
	maxJumpTime = 0.5,
	jumpTime = maxJumpTime
}

function updateTrex(dt)
	trex.anim: update(dt)

	local vx, vy = trex.vx, trex.vy

	local dx, dy = 0, 0

	if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
		dx = -vx * dt
	elseif love.keyboard.isDown("right") or love.keyboard.isDown("d") then
		dx = vx * dt
	end

	if (love.mouse.isDown(1) or love.keyboard.isDown("space")) and canJump(dt) then
		dy = -vy * dt
	else
		trex.jumpTime = trex.maxJumpTime
	end

	dy = dy + trex.gravity * dt

	if dx ~= 0 or dy ~= 0 then
		local cols, len
		trex.x, trex.y, cols, len = world: move(trex, trex.x + dx, trex.y + dy)

		trex.onGround = false
		for i = 1, len do
			local col = cols[i]
			checkIfOnGround(col.normal.y)
		end
	end

	if trex.onGround then
		trex.anim = trex.run
	else
		trex.anim = trex.idle
	end
end

function canJump(dt)
	if trex.onGround then
		trex.jumpTime = 0
		return true
	else
		trex.jumpTime = trex.jumpTime + dt
		if trex.jumpTime < trex.maxJumpTime then
			return true
		end

		return false
	end
end

function checkIfOnGround(ny)
	if ny < 0 then
		trex.onGround = true
	else
		trex.onGround = false
	end
end

function drawTrex()
	drawBox(trex, 0, 255, 0)
	trex.anim: draw(image, trex.x, trex.y)
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

	image = love.graphics.newImage('media/trex.png')

	local grid = anim8.newGrid(76, 76, 76*3, 76)

	trex.idle = anim8.newAnimation(grid(1, 1), 0.1)
	trex.run = anim8.newAnimation(grid('2-3', 1), 0.1)
	trex.anim = trex.run

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