# The Nature of Code
# NOC_6_04_Flowfield
class FlowField
  attr_reader :cols, :field, :resolution, :rows

  def initialize(resolution:, width:, height:)
    @resolution = resolution
    @cols = width / resolution
    @rows = height / resolution
    reset!
  end

  def display
    field.each_with_index do |row, i|
      row.each_with_index do |v, j|
        draw_vector(v, i * resolution, j * resolution, resolution - 1)
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
    column = constrain(vector.x / resolution, 0, cols - 1).to_i
    row = constrain(vector.y / resolution, 0, rows - 1).to_i
    field[column][row].copy
  end

  def reset!
    @field = create_field(cols, rows)
  end

  private

  def create_field(cols, rows)
    noise_seed(rand(10_000))
    xoff = -1
    Array.new(cols) do
      yoff = 0
      xoff += 1
      Array.new(rows) do
        theta = map1d(noise(xoff, yoff), (-1..1.0), (0..TWO_PI))
        yoff += 1
        Vec2D.new(cos(theta), sin(theta))
      end
    end
    # need to return field 2D Array
  end
end

class Vehicle
  attr_reader :acceleration, :location, :velocity, :width, :height

  def initialize(location:, maxspeed:, maxforce:, max_x:, max_y:)
    @acceleration = Vec2D.new
    @velocity = Vec2D.new(0, -2)
    @location = location
    @r = 6
    @maxspeed = maxspeed
    @maxforce = maxforce
    @width = max_x
    @height = max_y
  end

  def run
    update
    borders # ensure we don't lose those vehicles
    display
  end

  def apply_force(force:)
    @acceleration += force
  end

  def update
    @velocity += acceleration
    @velocity.set_mag(@maxspeed) { velocity.mag > @maxspeed }
    @location += velocity
    @acceleration *= 0
  end

  def follow(field: flowfield)
    # What is the vector at that spot in the flow field?
    desired = flowfield.lookup(location)
    # Scale it up by maxspeed
    desired *= @maxspeed
    # Steering is desired minus velocity
    steer = desired - velocity
    steer.set_mag(@maxforce) { steer.mag > @maxforce }
    apply_force(force: steer)
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
    location.x = width - @r if location.x < -@r
    location.y = height - @r if location.y < -@r
    location.x = -@r if location.x > width + @r
    location.y = -@r if location.y > height + @r
  end
end

attr_reader :flowfield, :vehicles

def setup
  sketch_title 'Flow Field'
  @flowfield = FlowField.new(
    resolution: 20,
    width: width,
    height: height
  )
  @vehicles = Array.new(120) do
    Vehicle.new(
      location: Vec2D.new(rand(width), rand(height)),
      maxspeed: rand(2.0..5),
      maxforce: rand(0.1..0.5),
      max_x: width,
      max_y: height
    )
  end
end

def draw
  background(255)
  vehicles.each do |v|
    v.follow(field: flowfield)
    v.run
  end
  flowfield.display
end

def settings
  size(640, 340)
end

def mouse_pressed
  flowfield.reset!
end
