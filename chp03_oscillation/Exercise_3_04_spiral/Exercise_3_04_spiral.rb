# Exercise_3_04_spiral
# The Nature of Code
# http://natureofcode.com

attr_reader :theta, :r

# A Polar coordinate, radius now starts at 0 to spiral outwards
def setup
  sketch_title 'Exercise 3 04 Spiral'
  background(255)
  @r = 0
  @theta = 0
end

def draw
  # Polar to Cartesian conversion
  x = r * cos(theta)
  y = r * sin(theta)
  # Draw an ellipse at x,y
  no_stroke
  fill(0)
  # Adjust for center of window
  ellipse(x + width / 2, y + height / 2, 16, 16)
  # Increment the angle
  @theta += 0.01
  # Increment the radius
  @r += 0.05
end

def settings
  size(750, 200)
  smooth 4
end

