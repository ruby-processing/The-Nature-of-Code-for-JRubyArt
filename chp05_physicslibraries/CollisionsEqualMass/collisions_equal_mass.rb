# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com

# Collisions -- Elastic, Equal Mass, Two objects only

# Based off of Chapter 9: Resolving Collisions
# Mathematics and Physics for Programmers by Danny Kodicek

# A Thing class for idealized collisions

require_relative 'mover'

attr_reader :a, :b, :show_vectors

def setup
  sketch_title 'Collisions Equal Mass'
  @a = Mover.new(self, Vec2D.new(rand(5.0), rand(-5..5.0)), Vec2D.new(10, 10))
  @b = Mover.new(self, Vec2D.new(-2, 1), Vec2D.new(150, 150))
  @show_vectors = true
end

def draw
  background 255
  a.go
  b.go
  # Note this function will ONLY WORK with two objects
  # Needs to be revised in the case of an array of objects
  a.collide_equal_mass(b)
end

def mouse_pressed
  @show_vectors = !show_vectors
end

def settings
  size(200, 200)
end
