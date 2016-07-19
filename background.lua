local Class = require 'class'

require "backgroundLayer"

Background = Class {
	init = function(self)

		self.layers = {}

		table.insert(self.layers, BackgroundLayer('media/background/background_01.png', 300, 0, 0))
		table.insert(self.layers, BackgroundLayer('media/background/background_02.png', 150, 0, 0))
		table.insert(self.layers, BackgroundLayer('media/background/background_03.png', 75, 0, 0))
		table.insert(self.layers, BackgroundLayer('media/background/background_04.png', 32, 0, 0))
		table.insert(self.layers, BackgroundLayer('media/background/background_05.png', 16, 0, 0))

		--self.layers[0] = BackgroundLayer('media/background/background_01.png', 300, 0, 0)
		--self.layers[1] = BackgroundLayer('media/background/background_02.png', 150, 0, 0)
		--self.layers[2] = BackgroundLayer('media/background/background_03.png', 75, 0, 0)
		--self.layers[3] = BackgroundLayer('media/background/background_04.png', 32, 0, 0)
		--self.layers[4] = BackgroundLayer('media/background/background_05.png', 16, 0, 0)
		--self.layer = BackgroundLayer('media/background/background_01.png', 300, 0, 0)

		self.sky = love.graphics.newImage('media/background/sky.png')

	end
}

function Background: update(dt)

	for i = 1, table.getn(self.layers) do
		self.layers[i]: update(dt)
	end

	--self.layer: update(dt)

end

function Background: draw()

	love.graphics.draw(self.sky, 0, 0)

	--for i = table.getn(self.layers), 1 do
	--	self.layers[i]: draw()
	--end
	self.layers[5]: draw()
	self.layers[4]: draw()
	self.layers[3]: draw()
	self.layers[2]: draw()
	self.layers[1]: draw()

	--self.layer: draw()
	
end