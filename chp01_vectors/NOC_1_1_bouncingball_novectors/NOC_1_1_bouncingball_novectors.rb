# NOC_1_1_bouncingball_novectors
# http://natureofcode.com
# Example 1-1: Bouncing Ball, no vectors

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
  @xspeed = -@xspeed if @x > width or @x < 0
  @yspeed = -@yspeed if @y > height or @y < 0
  # Display circle at x location
  stroke(0)
  stroke_weight(2)
  fill(127)
  ellipse(@x, @y, 48, 48)
end

def settings
  size(800, 200)
  smooth 4
end
