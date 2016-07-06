local Class = require 'class'
local bump = require 'bump'

require "obstacle"

Spawner = Class {
	init = function(self, world)
		self.world = world

	end,
	spawnTime = 2,
	currentTime = 0,
	obstacles = {},
	remove = false,
	removeIndx = 0
}

function Spawner: update(dt)

	if self.remove then
		table.remove(self.obstacles, self.removeIndx)
		self.remove = false
	end

	self.currentTime = self.currentTime + dt

	if self.currentTime >= self.spawnTime then
		self.currentTime = 0

		local obstacle = Obstacle(self.world, love.graphics.getWidth(), love.graphics.getHeight() - 32)
		table.insert(self.obstacles, obstacle)
	end

	for i = 1, table.getn(self.obstacles) do
		if self.obstacles[i]: isOutOfScreen() then
			self.obstacles[i]: destroy()
			self.remove = true
			self.removeIndx = i
			--table.remove(self.obstacles)
		else
			self.obstacles[i]: update(dt)
		end
	end
end

function Spawner: draw()
	for i = 1, table.getn(self.obstacles) do
		self.obstacles[i]: draw()
	end
end