# NOC_1_6_vector_normalize
# The Nature of Code
# http://natureofcode.com

# Demonstration of normalizing a vector.
# Normalizing a vector sets its length to 1.

def setup
  sketch_title 'Noc 1 6 Vector Normalize'
end

def draw
  background(255)
  # A vector that points to the mouse location
  mouse = Vec2D.new(mouse_x, mouse_y)
  # A vector that points to the center of the window
  center = Vec2D.new(width / 2, height / 2)
  # Subtract center from mouse which results in a vector that points from center to mouse
  mouse -= center
  # Normalize the vector
  mouse.normalize!
  # Multiply its length by 50
  mouse *= 50
  translate(width / 2, height / 2)
  # Draw the resulting vector
  stroke(0)
  stroke_weight(2)
  line(0, 0, mouse.x, mouse.y)
 end

def settings
  size 800, 200
  smooth 4
end

