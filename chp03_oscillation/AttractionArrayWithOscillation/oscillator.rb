# AttractionArrayWithOscillation
# The Nature of Code
# http://natureofcode.com

# Attraction Array with Oscillating objects around each thing
class Oscillator
  include Processing::Proxy
  attr_reader :amplitude, :theta

  def initialize(amplitude:)
    @theta = 0
    @amplitude = amplitude
  end

  def update(angle:)
    @theta += angle
  end

  def display
    x = map1d(cos(theta), (-1..1.0), (0..amplitude))
    stroke(0)
    fill(50)
    line(0, 0, x, 0)
    ellipse(x, 0, 8, 8)
  end
end
