local Class = require 'class'
local bump = require 'bump'

local obstacles_sprites = { "media/cactus1.png", 
					"media/cactus2.png", 
					"media/cactus3.png", 
					"media/cactus4.png", 
					"media/rock1.png", 
					"media/rock2.png" }

Obstacle = Class {
	init = function(self, world, width, height)
		local i = love.math.random(1, 6)
		self.sprite = love.graphics.newImage(obstacles_sprites[i])
		self.x = width
		self.y = height - self.sprite: getHeight()

		self.world = world
		self.world: add(self, self.x, self.y, self.sprite: getWidth(), self.sprite: getHeight())
	end
}

function Obstacle: update(dt, vx)
	local dx = -vx * dt

	self.x, self.y = self.world: move(self, self.x + dx, self.y)
end

function Obstacle: draw()
	love.graphics.draw(self.sprite, self.x, self.y)
	--love.graphics.rectangle('fill', self.x, self.y, 50, 70)
end

function Obstacle: isOutOfScreen()
	if self.x < - self.sprite: getWidth() then
		return true
	end

	return false
end

function Obstacle: destroy()
	self.world: remove(self)
end