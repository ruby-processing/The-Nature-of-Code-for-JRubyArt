# Basic example of falling rectangles
require 'pbox2d'
require_relative 'lib/custom_shape'

attr_reader :box2d, :boundaries, :polygons

def setup
  sketch_title 'Polygons'
  # Initialize box2d physics and create the world
  @box2d = Box2D.new(self)
  box2d.init_options(gravity: [0, -20])
  box2d.create_world
  # To later set a custom gravity
  # box2d.gravity([0, -20]
  # Create Arrays
  @polygons = []
  @boundaries = []
  # Add a bunch of fixed boundaries
  boundaries << Boundary.new(box2d, width / 4, height - 5, width / 2 - 50, 10, 0)
  boundaries << Boundary.new(box2d, 3 * width / 4, height - 50, width / 2 - 50, 10, 0)
  boundaries << Boundary.new(box2d, width - 5, height / 2, 10, height, 0)
  boundaries << Boundary.new(box2d, 5, height / 2, 10, height, 0)
end

def draw
  background(255)
  # Display all the boundaries
  boundaries.each(&:display)
  # Display all the polygons
  polygons.each(&:display)
  # polygons that leave the screen, we delete them
  # (note they have to be deleted from both the box2d world and our list
  polygons.reject!(&:done)
end

def mouse_pressed
  polygons << CustomShape.new(box2d, mouse_x, mouse_y)
end

def settings
  size(640, 360)
  smooth
end

