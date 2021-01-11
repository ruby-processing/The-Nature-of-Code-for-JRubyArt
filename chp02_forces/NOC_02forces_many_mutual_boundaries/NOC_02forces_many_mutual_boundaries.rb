# NOC_02forces_many_mutual_boundaries
# The Nature of Code
# http://natureofcode.com

require_relative 'mover'
attr_reader :movers

SIZE = 20

def setup
  sketch_title 'Forces Many Mutual Boundaries'
  @movers = (0..SIZE).map { Mover.new(rand(1.0..2), rand(width), rand(height)) }
end

def draw
  background(255)
  SIZE.times do |i|
    SIZE.times do |j|
      unless i == j
        attractor = movers[j].attract(mover: movers[i])
        movers[i].apply_force(force: attractor)
      end
    end
    movers[i].boundaries(max_x: width, max_y: height)
    movers[i].run
  end
end

def settings
  size(640, 360)
end
