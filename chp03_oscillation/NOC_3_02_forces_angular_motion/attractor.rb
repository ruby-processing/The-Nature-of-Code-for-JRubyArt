class Attractor
  include Processing::Proxy

  def initialize(location:)
    @location = location
    @mass = 20
    @g = 0.4
  end

  def attract(mover:)
    force = @location - mover.location
    distance = force.mag
    distance = constrain(distance, 5.0, 25.0)
    force.normalize!
    strength = (@g * @mass * mover.mass) / (distance * distance)
    force *= strength
    force
  end

  def display
    stroke(0)
    stroke_weight(2)
    fill(127)
    ellipse(@location.x, @location.y, 48, 48)
  end
end
