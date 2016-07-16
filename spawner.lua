local Class = require 'class'
local bump = require 'bump'

require "obstacle"

Spawner = Class {
	init = function(self, world)
		self.world = world

	end,
	spawnTime = 1.5,
	currentTime = 1.5,
	spawnVelocity = 300,
	obstacles = {},
	remove = false,
	removeIndx = 0
}

function Spawner: update(dt)

	self.spawnTime = self.spawnTime - dt * 0.01
	self.spawnVelocity = self.spawnVelocity + dt * 10

	if self.remove then
		table.remove(self.obstacles, self.removeIndx)
		self.remove = false
	end

	self.currentTime = self.currentTime - dt

	if self.currentTime <= 0 then
		self.currentTime = self.spawnTime

		local obstacle = Obstacle(self.world, love.graphics.getWidth(), love.graphics.getHeight() - 32)
		table.insert(self.obstacles, obstacle)
	end

	for i = 1, table.getn(self.obstacles) do
		if self.obstacles[i]: isOutOfScreen() then
			self.obstacles[i]: destroy()
			self.remove = true
			self.removeIndx = i
		else
			self.obstacles[i]: update(dt, self.spawnVelocity)
		end
	end
end

function Spawner: draw()
	for i = 1, table.getn(self.obstacles) do
		self.obstacles[i]: draw()
	end
end