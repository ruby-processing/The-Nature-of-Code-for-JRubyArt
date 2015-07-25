# NOC_3_03_pointing_velocity
# http://natureofcode.com
require_relative 'mover'

attr_reader :mover

def setup
  sketch_title 'Noc 3 03 Pointing Velocity'
  @mover = Mover.new(width / 2, height / 2)
end

def draw
  background(255)
  mover.update
  mover.check_edges
  mover.display
end

def settings
  size(640, 360)
end

