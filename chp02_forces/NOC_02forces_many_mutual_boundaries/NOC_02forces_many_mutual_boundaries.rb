# NOC_02forces_many_mutual_boundaries
# The Nature of Code
# http://natureofcode.com

require_relative 'mover'

attr_reader :movers

def setup
  sketch_title 'Forces Many Mutual Boundaries'
  @movers = Array.new(20)  { Mover.new(rand(1.0 .. 2), rand(width), rand(height)) }
end

def draw
  background(255)
  movers.size.times do |i|
    movers.size.times do |j|
      unless i == j
        attractor = movers[j].attract(mover: movers[i])
        movers[i].apply_force(force: attractor)
      end
    end
    movers[i].boundaries(max_x: width, max_y: height)
    movers[i].update
    movers[i].display
  end
end

def settings
  size(640, 360)
end
