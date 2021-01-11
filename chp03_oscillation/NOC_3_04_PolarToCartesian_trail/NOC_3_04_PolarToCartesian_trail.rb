# NOC_3_04_PolarToCartesian_trail
#  PolarToCartesian
#  by Daniel Shiffman.
#
#  Convert a polar coordinate (r,theta) to cartesian (x,y):
#  x = r * cos(theta)
#  y = r * sin(theta)

def setup
  sketch_title 'Polar To Cartesian Trail'
  background 255
  # Initialize all values
  @r = height * 0.45
  @theta = 0
end

def draw
  # background(255)
  no_stroke
  fill 255, 5
  rect(0, 0, width, height)
  # Translate the origin point to the center of the screen
  translate(width / 2, height / 2)
  # Convert polar to cartesian
  x = @r * cos(@theta)
  y = @r * sin(@theta)
  # Draw the ellipse at the cartesian coordinate
  ellipse_mode(CENTER)
  fill 127
  stroke(0)
  stroke_weight(2)
  line(0, 0, x, y)
  ellipse(x, y, 48, 48)
  # Increase the angle over time
  @theta += 0.02
end

def settings
  size 800, 200
end
