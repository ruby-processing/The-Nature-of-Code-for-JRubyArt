# The Nature of Code
# http://natureofcode.com

# Simple Particle System
# A simple Particle class
require_relative 'particle'
attr_reader :particles

def setup
  sketch_title 'Array Of Particles'
  @particles = []
end

def draw
  background(255)
  particles << Particle.new(location: Vec2D.new(width / 2, 50))
  particles.each(&:run)
  particles.reject!(&:dead?)
end

def settings
  size(640, 360)
end
