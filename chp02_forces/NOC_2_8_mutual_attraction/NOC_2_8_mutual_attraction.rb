# NOC_2_8_mutual_attraction
# http://natureofcode.com
require_relative 'mover'

def setup
  sketch_title 'Noc 2 8 Mutual Attraction'
  @movers = Array.new(20) { Mover.new(rand(width), rand(height), rand(0.1 .. 2)) }
end

def draw
  background(255)
  @movers.each do |m|
    @movers.each do |mm|
      next if m.equal? mm
      force = mm.attract(m)
      m.apply_force(force)
    end
    m.update
    m.display
  end
end

def settings
  size(800, 200)
end

