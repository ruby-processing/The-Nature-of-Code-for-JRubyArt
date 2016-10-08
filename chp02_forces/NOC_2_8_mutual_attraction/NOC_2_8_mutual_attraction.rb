# NOC_2_8_mutual_attraction
# http://natureofcode.com
require_relative 'mover'

def setup
  sketch_title 'Mutual Attraction'
  @movers = (0..19).map do
    Mover.new(
      location: Vec2D.new(rand(width), rand(height)),
      mass: rand(0.1..2)
    )
  end
end

def draw
  background(255)
  @movers.each do |m|
    @movers.each do |mm|
      next if m.equal? mm
      attraction = mm.attract(mover: m)
      m.apply_force(force: attraction)
    end
    m.update
    m.display
  end
end

def settings
  size(800, 200)
end
