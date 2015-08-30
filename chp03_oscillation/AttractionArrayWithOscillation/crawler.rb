# AttractionArrayWithOscillation
# The Nature of Code
# http://natureofcode.com

# Attraction Array with Oscillating objects around each thing
class Crawler
  include Processing::Proxy
  attr_reader :attractor, :loc, :mass, :acc, :vel

  def initialize(location:)
    @acc = Vec2D.new
    @vel = Vec2D.new(rand(-1.0..1), rand(-1.0..1))
    @loc = location.copy
    @mass = rand(8.0..16)
    @osc = Oscillator.new(amplitude: mass * 2)
  end

  def apply_force(force:)
    f = force.copy
    f /= mass
    @acc += f
  end

  # Method to update location
  def update
    @vel += acc
    @loc += vel
    # Multiplying by 0 sets the all the components to 0
    @acc *= 0
    @osc.update(angle: vel.mag / 10)
  end

  # Method to display
  def display
    angle = vel.heading
    push_matrix
    translate(loc.x, loc.y)
    rotate(angle)
    ellipse_mode(CENTER)
    stroke(0)
    fill(175, 100)
    ellipse(0, 0, mass * 2, mass * 2)
    @osc.display
    pop_matrix
  end
end
