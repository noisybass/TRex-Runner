local Class = require 'class'
local anim8 = require 'anim8'
local bump = require 'bump'

TRex = Class {
	init = function(self, world, sprite, x, y)
		self.sprite = sprite
		self.x = x
		self.y = y

		local grid = anim8.newGrid(76, 76, 76*3, 76)
		self.animations = {}
		self.animations.idle = anim8.newAnimation(grid(1, 1), 0.1)
		self.animations.run = anim8.newAnimation(grid('2-3', 1), 0.1)
		self.currentAnimation = self.animations.run

		self.world = world
		self.world: add(self, self.x, self.y, self.w, self.h)
	end,
	w = 76,
	h = 76,
	vx = 150,
	vy = 600,
	gravity = 300,
	onGround = false,
	maxJumpTime = 0.5,
	jumpTime = maxJumpTime
}

function TRex: update(dt)
	self.currentAnimation: update(dt)

	local vx, vy = TRex.vx, TRex.vy
	local dx, dy = 0, 0

	if (love.mouse.isDown(1) or love.keyboard.isDown("space")) and TRex: canJump(dt) then
		dy = -vy * dt
	else
		TRex.jumpTime = TRex.maxJumpTime
	end

	dy = dy + TRex.gravity * dt

	if dx ~= 0 or dy ~= 0 then
		local cols, len
		self.x, self.y, cols, len = self.world: move(self, self.x + dx, self.y + dy)

		TRex.onGround = false
		for i = 1, len do
			local col = cols[i]
			TRex: checkIfOnGround(col.normal.y)
		end
	end

	if TRex.onGround then
		self.currentAnimation = self.animations.run
	else
		self.currentAnimation = self.animations.idle
	end	
end

function TRex: draw()
	self.currentAnimation: draw(self.sprite, self.x, self.y)
end

function TRex: canJump(dt)
	if TRex.onGround then
		TRex.jumpTime = 0
		return true
	else
		TRex.jumpTime = TRex.jumpTime + dt
		if TRex.jumpTime < TRex.maxJumpTime then
			return true
		end
		return false
	end
end

function TRex: checkIfOnGround(ny)
	if ny < 0 then
		TRex.onGround = true
	else
		TRex.onGround = false
	end
end