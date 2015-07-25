require 'pbox2d'
require_relative 'lib/custom_listener'
require_relative 'lib/particle'
require_relative 'lib/boundary'

attr_reader :box2d, :particles, :wall

def setup
  sketch_title 'Collision Listening'
  @box2d = Box2D.new(self)
  box2d.create_world
  box2d.add_listener(CustomListener.new)
  @particles = []
  @wall = Boundary.new(box2d, width / 2, height - 5, width, 10)
end

def draw
  background(255)
  particles << Particle.new(box2d, rand(width), 20, rand(4..8)) if rand < 0.1
  particles.each{ |p| p.display(self) }
  particles.reject!(&:done)
  wall.display(self)
end
def settings
  size 400, 400
end

