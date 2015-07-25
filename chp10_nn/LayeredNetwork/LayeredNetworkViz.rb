# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com
load_library :neural_network

attr_reader :network

def setup
  sketch_title 'Layered Network Viz'
  @network = StaticNetwork.new 4, 3, 1
end

def draw
  background 255
  network.display
end

def settings
  size 640, 360
  smooth 4
end

