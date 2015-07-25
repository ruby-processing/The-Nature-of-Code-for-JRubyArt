# The Nature of Code
# http://natureofcode.com

# Simple Particle System
# A simple Particle class
require_relative 'particle'

attr_reader :particles

def setup
  sketch_title 'Noc 4 02 Array List Particles'
  @particles = []
end

def draw
  background(255)
  particles << Particle.new(Vec2D.new(width / 2, 50))
  particles.each { |p| p.run }
  particles.reject! { |p| p.dead? }
end

def settings
  size(640, 360)
end

