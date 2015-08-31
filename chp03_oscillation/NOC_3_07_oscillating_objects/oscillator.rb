class Oscillator
  include Processing::Proxy

  attr_reader :angle, :amplitude, :velocity, :width, :height
  def initialize(max_x:, max_y:)
    @width, @height = max_x, max_y
    @angle = Vec2D.new
    @velocity = Vec2D.new(rand(-0.05..0.05), rand(-0.05..0.05))
    @amplitude = Vec2D.new(rand(20..width / 2), rand(20..height / 2))
  end

  def oscillate
    @angle += velocity
  end

  def display
    x = sin(angle.x) * amplitude.x
    y = sin(angle.y) * amplitude.y
    push_matrix
    translate(width / 2, height / 2)
    stroke(0)
    stroke_weight(2)
    fill(127, 127)
    line(0, 0, x, y)
    ellipse(x, y, 32, 32)
    pop_matrix
  end
end
