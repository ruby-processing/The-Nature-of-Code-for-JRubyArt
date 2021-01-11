# The Nature of Code
# PBox2D example

# An uneven surface boundary

class Surface
  include Processing::Proxy
  # We'll keep track of all of the surface points
  attr_reader :surface, :body, :box2d, :y, :width, :height

  def initialize(b2d)
    @box2d = b2d
    @surface = []
    @width = b2d.width
    @height = b2d.height
    # This is what box2d uses to put the surface in its world
    chain = ChainShape.new
    # Perlin noise argument
    xoff = 0.0
    # This has to go backwards so that the objects  bounce off the top of the surface
    # This "edgechain" will only work in one direction!
    (width + 10).step(-10, -5) do |x|
      # Doing some stuff with perlin noise to calculate a surface that points down on one side
      # and up on the other
      @y = if x > width / 2
             100 + (width - x) * 1.1 + map1d(noise(xoff), (0..1.0), (-80..80))
           else
             100 + x * 1.1 + map1d(noise(xoff), (0..1.0), (-80..80))
           end
      # Store the vertex in screen coordinates
      surface << Vec2.new(x, y)
      # Move through perlin noise
      xoff += 0.1
    end
    # Build an array of vertices in Box2D coordinates
    # from the ArrayList we made
    vertices = []
    surface.each do |surf|
      vertices << box2d.processing_to_world(surf)
    end
    # Create the chain!
    chain.createChain(vertices, vertices.length)
    # The edge chain is now attached to a body via a fixture
    bd = BodyDef.new
    bd.position.set(0.0, 0.0)
    @body = box2d.createBody(bd)
    # Shortcut, we could define a fixture if we
    # want to specify frictions, restitution, etc.
    body.createFixture(chain, 1)
  end

  # A simple function to just draw the edge chain as a series of vertex points
  def display
    stroke_weight(2)
    stroke(0)
    fill(135, 206, 250)
    begin_shape
    vertex(width, 0)      # extra vertices so we can fill sky
    surface.each do |v|
      vertex(v.x, v.y)    # the mountain range
    end
    vertex(0, 0)          # extra vertices so we can fill sky
    end_shape
  end
end

class Particle
  include Processing::Proxy
  # We need to keep track of a Body

  attr_reader :body, :box2d, :x, :y, :r

  # Constructor
  def initialize(b2d, x, y, r)
    @box2d = b2d
    @x = x
    @y = y
    @r = r
    # This function puts the particle in the Box2d world
    make_body(x, y, r)
  end

  # This function removes the particle from the box2d world
  def kill_body
    box2d.destroy_body(body)
  end

  # Is the particle ready for deletion?
  def done
    pos = box2d.body_coord(body)
    # Is it off the bottom of the screen?
    return false unless pos.y > box2d.height + r * 2

    kill_body
    true
  end

  def display
    # We look at each body and get its screen position
    pos = box2d.body_coord(body)
    # Get its angle of rotation
    a = body.get_angle
    push_matrix
    translate(pos.x, pos.y)
    rotate(-a)
    fill(175)
    stroke(0)
    stroke_weight(1)
    ellipse(0, 0, r * 2, r * 2)
    # Let's add a line so we can see the rotation
    line(0, 0, r, 0)
    pop_matrix
  end

  # This function adds the rectangle to the box2d world
  def make_body(x, y, r)
    # Define and create the body
    bd = BodyDef.new
    bd.position = box2d.processing_to_world(x, y)
    bd.type = BodyType::DYNAMIC
    @body = box2d.create_body(bd)
    # Make the body's shape a circle
    cs = CircleShape.new
    cs.m_radius = box2d.scale_to_world(r)
    fd = FixtureDef.new
    fd.shape = cs
    # Parameters that affect physics
    fd.density = 1
    fd.friction = 0.01
    fd.restitution = 0.3
    # Attach fixture to body
    body.create_fixture(fd)
    # Give it a random initial velocity (and angular velocity)
    body.set_linear_velocity(Vec2.new(rand(-10..10), rand(5..10)))
    body.set_angular_velocity(rand(-10..10))
  end
end
