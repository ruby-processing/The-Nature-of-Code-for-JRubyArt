# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com
# Basic example of falling rectangles

require 'pbox2d'
require_relative 'lib/box'

attr_reader :boxes, :boundaries, :box2d

def setup
  sketch_title 'Liquid Fun Test'
  # @box2d = Box2D.new(self)
  # box2d.init_options(gravity: [0, -10])
  # box2d.create_world
  @box2d = WorldBuilder.build(app: self, gravity: [0, -10])
  @boundaries = []
  @boxes = []
  box2d.world.set_particle_radius(0.15)
  box2d.world.set_particle_damping(0.2)
  boundaries << Boundary.new(box2d, width / 4, height - 5, width / 2 - 50, 10)
  boundaries << Boundary.new(box2d, 3 * width / 4, height - 50, width / 2 - 50, 10) 
end

def mouse_pressed
  boxes << Box.new(box2d, mouse_x, mouse_y)
end

def draw
  background(255)
  boundaries.each(&:display)
  pos_buffer = box2d.world.particle_position_buffer
  return if pos_buffer.nil?
  stroke(0)
  stroke_weight(2)
  pos_buffer.each do |buf|
    pos = box2d.world_to_processing(buf)
    point(pos.x, pos.y)
  end
  fill(0)
  text(format('f.p.s %s', frame_rate.to_i), 10, 60)
end

def settings
  size(640, 360, P2D)
end
