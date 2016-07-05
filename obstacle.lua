local Class = require 'class'
local bump = require 'bump'

Obstacle = Class {
	init = function(self, world)
		self.sprite = love.graphics.newImage('media/cactus1.png')
		self.x = love.graphics.getWidth()
		self.y = love.graphics.getHeight() - 76 - 32

		self.world = world
		self.world: add(self, self.x, self.y, 56, 76)
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