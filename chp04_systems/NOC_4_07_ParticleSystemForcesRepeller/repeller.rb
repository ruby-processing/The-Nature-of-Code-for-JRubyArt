class Repeller
  include Processing::Proxy

  G = 100
  attr_reader :location
  def initialize(origin:)
    @location = origin
  end

  def display
    stroke(0)
    stroke_weight(2)
    fill(175)
    ellipse(location.x, location.y, 48, 48)
  end

  def repel(particle:)
    dir = location - particle.location           # Calculate direction of force
    d = dir.mag                                  # Distance between objects
    dir.normalize!                               # Normalize vector (distance doesn't matter here, we just want this vector for direction)
    d = constrain(d, 5.0, 100.0)                 # Keep distance within a reasonable range of float
    force =  -1 * G / (d * d)                    # Repelling force is inversely proportional to distance
    dir *= force                                 # Get force vector --> magnitude * direction
  end
end
