class Mover
  include Processing::Proxy
  attr_reader :location, :mass

  def initialize(m, x, y)
    @mass = m
    @location = Vec2D.new(x,y)
    @velocity = Vec2D.new(rand(-1.0 .. 1), rand(-1.0 .. 1))
    @acceleration = Vec2D.new(0, 0)
    @angle = 0
    @a_velocity = 0
    @a_acceleration = 0
  end

  def apply_force(force)
    f = force / @mass
    @acceleration += f
  end

  def update
    @velocity += @acceleration
    @location += @velocity
    @a_acceleration = @acceleration.x / 10.0
    @a_velocity += @a_acceleration
    @a_velocity = constrain(@a_velocity, -0.1, 0.1)
    @angle += @a_velocity
    @acceleration *= 0
  end

  def display
    stroke(0)
    fill(175, 200)
    rect_mode(CENTER)
    push_matrix
    translate(@location.x, @location.y)
    rotate(@angle)
    rect(0, 0, @mass * 16, @mass * 16)
    pop_matrix
  end
end
