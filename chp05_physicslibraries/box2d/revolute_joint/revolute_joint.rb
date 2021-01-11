# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com

# Example demonstrating revolute joint
require 'pbox2d'
require 'forwardable'
require_relative 'windmill'
require_relative 'particle'

attr_reader :box2d, :windmill, :particles

def setup
  sketch_title 'Revolute Joint'
  @box2d = Box2D.new(self)
  box2d.createWorld
  @windmill = Windmill.new(width / 2, 175)
  @particles = []
end

# Click the mouse to turn on or off the motor
def mouse_pressed
  windmill.toggle_motor
end

def draw
  background(255)
  if rand < 0.1
    sz = rand(4.0..8)
    particles << Particle.new(rand(width / 2 - 100..width / 2 + 100), -20, sz)
  end
  particles.each(&:display)
  particles.reject!(&:done?)
  # Draw the windmill
  windmill.display
  status = windmill.motor_on? ? 'ON' : 'OFF'
  fill(0)
  text(format("Click mouse to toggle motor.\nMotor: %s", status), 10, height - 30)
end

def settings
  size(640, 360)
end
