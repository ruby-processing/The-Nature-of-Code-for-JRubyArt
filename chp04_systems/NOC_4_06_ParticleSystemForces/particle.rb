class Particle
  include Processing::Proxy
  attr_reader :acceleration, :lifespan, :location, :velocity

  def initialize(location:)
    @acceleration = Vec2D.new(0, 0)
    @velocity = Vec2D.new(rand(-1.0..1), rand(-2..0))
    @location = location
    @lifespan = 255.0
    @mass = 1
  end

  def run
    update
    display
  end

  def apply_force(force:)
    f = force / @mass
    @acceleration += f
  end

  # Method to update location
  def update
    @velocity += acceleration
    @location += velocity
    @acceleration *= 0
    @lifespan -= 2.0
  end

  # Method to display
  def display
    stroke(0, lifespan)
    stroke_weight(2)
    fill(127, lifespan)
    ellipse(location.x, location.y, 12, 12)
  end

  # Is the particle still useful?
  def dead?
    lifespan < 0.0
  end
end
