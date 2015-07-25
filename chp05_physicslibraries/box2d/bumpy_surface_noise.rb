# The Nature of Code
# PBox2D example
# An uneven surface

require 'pbox2d'
require_relative 'lib/surface'

attr_reader :surface, :box2d, :particles

def setup
  sketch_title 'Bumpy Surface Noise'
  # Initialize box2d physics and create the world
  @box2d = Box2D.new(self)
  box2d.init_options(gravity: [0, -20])
  box2d.create_world
  # to later set a custom gravity
  # box2d.gravity([0, -20])
  # Create the empty list
  @particles = []
  # Create the surface
  @surface = Surface.new(box2d)
end

def draw
  # If the mouse is pressed, we make new particles
  # We must always step through time!
  background(138, 66, 54)
  # Draw the surface
  surface.display
  # NB ? reqd to call mouse_pressed value, else method gets called.
  particles << Particle.new(box2d, mouse_x, mouse_y, rand(2.0..6)) if mouse_pressed?
  # Draw all particles
  particles.each(&:display)
  # Particles that leave the screen, we delete them
  # (note they have to be deleted from both the box2d world and our list
  particles.reject!(&:done)
  # Just drawing the framerate to see how many particles it can handle
  fill(0)
  text("framerate: #{frame_rate.to_i}", 12, 16)
end

def settings
  size(500, 300)
  smooth 4
end

