# AttractionArrayWithOscillation
# The Nature of Code
# http://natureofcode.com

# Attraction Array with Oscillating objects around each thing
require_relative 'attractor'
require_relative 'crawler'
require_relative 'oscillator'

attr_reader :attractor, :crawlers

# AttractionArrayWithOscillation
def setup
  sketch_title 'Attraction Array With Oscillation'
  # Some random crawler bodies
  @crawlers = (0..4).map do
    Crawler.new(location: Vec2D.new(rand(width), rand(height)))
  end
  # Create an attractor body
  @attractor = Attractor.new(
    location: Vec2D.new(width / 2, height / 2),
    mass: 20,
    gravity: 0.4
  )
end

def draw
  background(255)
  attractor.move(position: Vec2D.new(mouse_x, mouse_y))
  crawlers.each do |c|
    attraction = attractor.attract(crawler: c)
    c.apply_force(force: attraction)
    c.update
    c.display
  end
end

def mouse_pressed
  attractor.clicked(position: Vec2D.new(mouse_x, mouse_y))
end

def mouse_released
  attractor.stop_dragging
end

def settings
  size(640, 360)
end
