local Class = require 'class'
local bump = require 'bump'

local obstacles = { "media/cactus1.png", 
					"media/cactus2.png", 
					"media/cactus3.png", 
					"media/cactus4.png", 
					"media/rock1.png", 
					"media/rock2.png" }

Obstacle = Class {
	init = function(self, world, width, height)
		local i = love.math.random(0, 5)
		self.sprite = love.graphics.newImage(obstacles[i])
		self.x = width
		self.y = height - self.sprite: getHeight()

		self.world = world
		self.world: add(self, self.x, self.y, self.sprite: getWidth(), self.sprite: getHeight())
	end,
	vx = 200
}

function Obstacle: update(dt)
	local vx = Obstacle.vx
	local dx = -vx * dt

	self.x, self.y = self.world: move(self, self.x + dx, self.y)
end

function Obstacle: draw()
	love.graphics.draw(self.sprite, self.x, self.y)
	--love.graphics.rectangle('fill', self.x, self.y, 50, 70)
end