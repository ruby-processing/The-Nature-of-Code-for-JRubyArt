# Exercise_2_10_attractrepel
# The Nature of Code
# http://natureofcode.com
require_relative 'attractor'
require_relative 'mover'

def setup
  sketch_title 'Attract Repel Exercise'
  @attractor = Attractor.new(location: Vec2D.new(width / 2, height / 2))
  @movers = (0..19).map do
    Mover.new(
      mass: rand(4.0..12),
      location: Vec2D.new(rand(width), rand(height))
    )
  end
end

def draw
  background(255)
  @attractor.display
  @movers.each do |m|
    @movers.each do |mm|
      next if m.equal? mm
      repel = mm.repel(mover: m)
      m.apply_force(force: repel)
    end
    attraction = @attractor.attract(mover: m)
    m.apply_force(force: attraction)
    m.update
    m.display
  end
end

def settings
  size(800, 200)
end
