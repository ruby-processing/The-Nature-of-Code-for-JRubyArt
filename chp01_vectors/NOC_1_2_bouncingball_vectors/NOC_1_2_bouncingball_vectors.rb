# NOC_1_2_bouncingball_vectors
# The Nature of Code
# http://natureofcode.com
# Example 1-2: Bouncing Ball, with Vec2D!

def setup
  sketch_title 'Noc 1 2 Bouncingball Vectors'
  background(255)
  @location = Vec2D.new(100.0, 100.0)
  @velocity = Vec2D.new(2.5, 5.0)
end

def draw
  no_stroke
  fill(255, 10)
  rect(0, 0, width, height)
  # Add the current speed to the location.
  @location += @velocity
  @velocity.x = -@velocity.x unless (0 .. width).include? @location.x
  @velocity.y = -@velocity.y unless (0 .. height).include? @location.y
  # Display circle at x location
  stroke(0)
  fill(175)
  ellipse(@location.x, @location.y, 16, 16)
end

def settings
  size(200,200)
end

