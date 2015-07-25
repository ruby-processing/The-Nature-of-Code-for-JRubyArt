# NOC_3_02_forces_angular_motion
# The Nature of Code
# http://natureofcode.com
require_relative 'attractor'
require_relative 'mover'

# NOC_3_02_forces_angular_motion
def setup
  sketch_title 'Noc 3 02 Forces Angular Motion'
  background(255)
  @movers = Array.new(20) { Mover.new(rand(0.1 .. 2), rand(width), rand(height)) }
  @a = Attractor.new(width, height)
end

def draw
  background(255)
  @a.display
  @movers.each do |m|
    force = @a.attract(m)
    m.apply_force(force)
    m.update
    m.display
  end
end

def settings
  size(640, 360)
end

