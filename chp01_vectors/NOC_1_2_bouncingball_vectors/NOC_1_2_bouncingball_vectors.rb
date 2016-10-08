# NOC_1_2_bouncingball_vectors
# The Nature of Code
# http://natureofcode.com
# Example 1-2: Bouncing Ball, with Vec2D!
RADIUS = 8

def setup
  sketch_title 'Bouncing Ball With Vectors'
  background(255)
  @loc = Vec2D.new(100.0, 100.0)
  @vel = Vec2D.new(2.5, 5.0)
end

def draw
  no_stroke
  fill(255, 10)
  rect(0, 0, width, height)
  # Add the current speed to the loc.
  @loc += @vel
  @vel.x = -@vel.x unless (RADIUS..width - RADIUS).cover? @loc.x
  @vel.y = -@vel.y unless (RADIUS..height - RADIUS).cover? @loc.y
  # Display circle at x loc
  stroke(0)
  fill(175)
  ellipse(@loc.x, @loc.y, RADIUS * 2, RADIUS * 2)
end

def settings
  size(200, 200)
end
