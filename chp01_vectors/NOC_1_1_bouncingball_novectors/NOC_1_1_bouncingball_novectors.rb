# NOC_1_1_bouncingball_novectors
# http://natureofcode.com
# Example 1-1: Bouncing Ball, no vectors
RADIUS = 24

def setup
  sketch_title 'Bouncing Ball No Vectors'
  @x = 100
  @y = 100
  @xspeed = 2.5
  @yspeed = 2
end

def draw
  background(255)
  # Add the current speed to the location.
  @x += @xspeed
  @y += @yspeed
  @xspeed = -@xspeed unless (RADIUS..width - RADIUS).cover?(@x)
  @yspeed = -@yspeed unless (RADIUS..height - RADIUS).cover?(@y)
  # Display circle at x location
  stroke(0)
  stroke_weight(2)
  fill(127)
  ellipse(@x, @y, 2 * RADIUS, 2 * RADIUS)
end

def settings
  size(800, 200)
  smooth 4
end
