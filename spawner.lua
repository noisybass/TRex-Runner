local Class = require 'class'
local bump = require 'bump'

require "obstacle"

Spawner = Class {
	init = function(self, world)
		self.world = world

	end,
	spawnTime = 2,
	currentTime = 0,
	obstacles = {}
}

function Spawner: update(dt)

	self.currentTime = self.currentTime + dt

	if self.currentTime >= self.spawnTime then
		self.currentTime = 0

		local obstacle = Obstacle(self.world, love.graphics.getWidth(), love.graphics.getHeight() - 32)
		table.insert(self.obstacles, obstacle)
	end

	for i = 1, table.getn(self.obstacles) do
		self.obstacles[i]: update(dt)
	end
end

function Spawner: draw()
	for i = 1, table.getn(self.obstacles) do
		self.obstacles[i]: draw()
	end
end