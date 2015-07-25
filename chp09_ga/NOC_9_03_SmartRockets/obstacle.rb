# A class for an obstacle, just a simple rectangle that is drawn
# and can check if a Rocket touches it
# Also using this class for target location
class Obstacle
  include Processing::Proxy
  attr_reader :location
  def initialize(x, y, w_, h_)
    @location = Vec2D.new(x, y)
    @w = w_
    @h = h_
  end

  def display
    stroke(0)
    fill(175)
    stroke_weight(2)
    rect_mode(CORNER)
    rect(location.x, location.y, @w, @h)
  end

  def contains(spot)
    ((location.x..location.x + @w).include? spot.x) &&
      ((location.y..location.y + @h).include? spot.y)
  end
end
