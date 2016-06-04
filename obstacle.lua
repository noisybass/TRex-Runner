local Class = require 'class'
local bump = require 'bump'

Obstacle = Class {
	init = function(self, world, x, y)
		--self.sprite = sprite
		self.x = x
		self.y = y

		self.world = world
		self.world: add(self, self.x, self.y, 50, 70)
	end,
	vx = 200
}

function Obstacle: update(dt)
	local vx = Obstacle.vx
	local dx = -vx * dt

	self.x, self.y = self.world: move(self, self.x + dx, self.y)
end

function Obstacle: draw()
	--love.graphics.draw(self.sprite, self.x, self.y)
	love.graphics.rectangle('fill', self.x, self.y, 50, 70)
end