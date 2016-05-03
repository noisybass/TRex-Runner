local anim8 = require 'anim8'

local x, y = 400, 300

function love.load()

	-- One meter is 64px in physics engine
	love.physics.setMeter(64)

	-- Create a world with standard gravity
	world = love.physics.newWorld(0, 9.81*64, true)

	-- Create the ground body at (0, 0) static
	ground = love.physics.newBody(world, 0, 0, "static")
	
	-- Create the ground shape at (400,500) with size (600,10).
	ground_shape = love.physics.newRectangleShape( 400, 500, 600, 10)

	-- Create fixture between body and shape
	ground_fixture = love.physics.newFixture( ground, ground_shape)

	image = love.graphics.newImage('media/trex_run.png')

	-- Create a Body for the circle
	body = love.physics.newBody(world, 400, 200, "dynamic")
	
	-- Attatch a shape to the body.
	circle_shape = love.physics.newRectangleShape( 0, 0, 128, 128)
	
    -- Create fixture between body and shape
    fixture = love.physics.newFixture( body, circle_shape)

    -- Calculate the mass of the body based on attatched shapes.
	-- This gives realistic simulations.
	body:setMassData(circle_shape:computeMass( 1 ))



	local grid = anim8.newGrid(128, 128, 256, 128)

	animation = anim8.newAnimation(grid('1-2', 1), 0.1)
end

function love.update(dt)

	-- Update the world.
	world:update(dt)

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
	if love.keyboard.isDown("space") then
		-- Apply a random impulse
		body:applyLinearImpulse(0,-10)
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

	-- Draws the ground.
	love.graphics.polygon("line", ground:getWorldPoints(ground_shape:getPoints()))

	--love.graphics.draw(image,body:getX(), body:getY(), body:getAngle(),1,1,64,64)

	--animation: draw(image, x, y)
	animation: draw(image, body:getX() - 64, body:getY() - 64)
end

function love.mousepressed(x, y, button, istouch)
	if button == 1 then
		animation: flipH()
	end
end

function love.keypressed(key)
    if key == "escape" then
       love.event.quit()
    end
end