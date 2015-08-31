# NOC_3_02_forces_angular_motion
# The Nature of Code
# http://natureofcode.com
require_relative 'attractor'
require_relative 'mover'

# NOC_3_02_forces_angular_motion
def setup
  sketch_title 'Forces Angular Motion'
  background(255)
  @movers = (0..19).map do
    Mover.new(
      mass: rand(0.1..2),
      location: Vec2D.new(rand(width), rand(height))
    )
  end
  @a = Attractor.new(location: Vec2D.new(width / 2, height / 2))
end

def draw
  background(255)
  @a.display
  @movers.each do |m|
    attraction = @a.attract(mover: m)
    m.apply_force(force: attraction)
    m.update
    m.display
  end
end

def settings
  size(640, 360)
end
