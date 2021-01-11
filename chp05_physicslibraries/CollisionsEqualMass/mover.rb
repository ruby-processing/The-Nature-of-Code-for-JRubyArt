# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com
# Collisions

require_relative 'world'

def draw_vector(app, v, loc, scayl)
  app.push_matrix
  arrowsize = 4
  # Translate to location to render vector
  app.translate(loc.x, loc.y)
  app.stroke(0)
  # Call vector heading function to get direction (note that pointing up is a
  # heading of 0) and rotate
  app.rotate(v.heading)
  # Calculate length of vector & scale it to be bigger or smaller if necessary
  len = v.mag * scayl
  # Draw three lines to make an arrow (draw pointing up since we've rotate to
  # the proper direction)
  app.line(0, 0, len, 0)
  app.line(len, 0, len - arrowsize, +arrowsize / 2)
  app.line(len, 0, len - arrowsize, -arrowsize / 2)
  app.pop_matrix
end

# Class knows where it is loc (Vec2D)
# and where it is going vel (Vec2D)
# but also needs to know how to show itself app (Applet)
class Mover
  attr_accessor :vel
  attr_reader :world, :colliding, :loc, :r, :app

  def initialize(app:, velocity:, location:)
    @app = app
    @vel = velocity
    @loc = location
    @r = 20
    @world = World.new((r..app.width - r), (r..app.height - r))
    @colliding = false
  end

  # Main method to operate object
  def go
    update
    borders
    display
  end

  # Method to update location
  def update
    @loc += vel
  end

  # Check for bouncing off borders
  def borders
    world.constrain_mover(self)
  end

  # Method to display
  def display
    app.ellipseMode(Java::ProcessingCore.PConstants::CENTER)
    app.stroke(0)
    app.fill(175, 200)
    app.ellipse(loc.x, loc.y, r * 2, r * 2)
    draw_vector(app, vel, loc, 10) if app.show_vectors
  end

  def collide_equal_mass(other)
    d = loc.dist(other.loc)
    sum_r = r + other.r
    # Are they colliding?
    if !colliding && d < sum_r
      # Yes, make new velocities!
      @colliding = true
      # Direction of one object another
      n = other.loc - loc
      n.normalize!
      # Difference of velocities so that we think of one object as stationary
      u = vel - other.vel
      # Separate out components -- one in direction of normal
      un = component_vector(u, n)
      # Other component
      u -= un
      # These are the new velocities plus the velocity of the object we consider
      # as stationary
      @vel = u + other.vel
      other.vel += un
    elsif d > sum_r
      @colliding = false
    end
  end
end

def component_vector(vector, direction_vector)
  #--! ARGUMENTS: vector, direction_vector (2D vectors)
  #--! RETURNS: the component vector of vector in the direction direction_vector
  #-- normalize directionVector
  direction_vector.normalize!
  direction_vector * vector.dot(direction_vector)
end
