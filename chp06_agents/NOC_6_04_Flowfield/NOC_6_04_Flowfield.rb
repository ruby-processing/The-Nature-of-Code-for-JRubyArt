
# The Nature of Code
# NOC_6_04_Flowfield

class FlowField
  def initialize(r, width, height)
    @resolution = r
    @cols = width / @resolution
    @rows = height / @resolution

    noise_seed(rand(10_000))
    xoff = -1
    @field = Array.new(@cols) do
      yoff = 0
      xoff += 1
      Array.new(@rows) do
        theta = map1d(noise(xoff, yoff), (0..1), (0..TWO_PI))
        yoff += 1
        Vec2D.new(cos(theta), sin(theta))
      end
    end
  end

  def display
    @field.each_with_index do |row, i|
      row.each_with_index do |v, j|
        draw_vector(v, i * @resolution, j * @resolution, @resolution - 1)
      end
    end
  end

  def draw_vector(v, x, y, scayl)
    push_matrix
    translate(x, y)
    stroke(0, 100)
    rotate(v.heading)
    len = v.mag * scayl
    line(0, 0, len, 0)
    pop_matrix
  end

  def lookup(vector)
    column = (0..@cols - 1).clip(vector.x / @resolution)
    row = (0..@rows - 1).clip(vector.y / @resolution)
    @field[column][row].copy
  end
end

class Vehicle
  attr_reader :acceleration, :location, :velocity, :world

  def initialize(loc, maxspeed, maxforce, world)
    @acceleration = Vec2D.new
    @velocity = Vec2D.new(0, -2)
    @location = loc.copy
    @r = 6
    @maxspeed = maxspeed
    @maxforce = maxforce
    @world = world
  end

  def run
    update
    borders
    display
  end

  def apply_force(force)
    @acceleration += force
  end

  def update
    @velocity += acceleration
    @velocity.set_mag(@maxspeed) { velocity.mag > @maxspeed }
    @location += velocity
    @acceleration *= 0
  end

  def follow(flowfield)
    # What is the vector at that spot in the flow field?
    desired = flowfield.lookup(location)
    # Scale it up by maxspeed
    desired *= @maxspeed
    # Steering is desired minus velocity
    steer = desired - velocity
    steer.set_mag(@maxforce) { steer.mag > @maxforce }
    apply_force(steer)
  end

  def display
    theta = velocity.heading + PI / 2
    fill(127)
    stroke(0)
    stroke_weight(1)
    push_matrix
    translate(location.x, location.y)
    rotate(theta)
    begin_shape
    vertex(0, -@r * 2)
    vertex(-@r, @r * 2)
    vertex(@r, @r * 2)
    end_shape(CLOSE)
    pop_matrix
  end

  def borders
    @location.x = world.width + @r if location.x < -@r
    @location.y = world.height + @r if location.y < -@r
    @location.x = -@r if location.x > world.width + @r
    @location.y = -@r if location.y > world.height + @r
  end
end

def setup
  sketch_title 'Noc 6 04 Flowfield'
  @flowfield = FlowField.new(20, width, height)
  @vehicles = Array.new(120) do
    Vehicle.new(
      Vec2D.new(rand(width), rand(height)),
      rand(2.0..5),
      rand(0.1..0.5),
      self
    )
  end
end

def draw
  background(255)
  @vehicles.each do |v|
    v.follow(@flowfield)
    v.run
  end
  @flowfield.display
end

def settings
  size(640, 340)
end

