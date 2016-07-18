local Class = require 'class'

BackgroundLayer = Class {
	init = function(self, file, speed, x, y)

		self.file = file
		self.image = love.graphics.newImage(file)
		self.speed = speed
		self.xa = x
		self.xb = self.xa + self.image: getWidth()

	end
}

function BackgroundLayer: update(dt)

	self.xa = self.xa - self.speed * dt
	self.xb = self.xb - self.speed * dt

	if (self.xa < - self.image: getWidth()) then
		self.xa = self.image: getWidth()
	elseif (self.xb < - self.image: getWidth()) then
		self.xb = self.image: getWidth()
	end
end

function BackgroundLayer: draw()

	love.graphics.draw(self.image, self.xa, 0)
	love.graphics.draw(self.image, self.xb, 0)

end

