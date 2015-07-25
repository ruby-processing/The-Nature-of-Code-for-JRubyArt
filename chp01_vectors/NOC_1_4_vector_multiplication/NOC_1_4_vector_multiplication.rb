# NOC_1_4_vector_multiplication
# The Nature of Code
# http://natureofcode.com
# Example 1-4: Vector multiplication

def setup
  sketch_title 'Noc 1 4 Vector Multiplication'
end

def draw
  background 255
  mouse = Vec2D.new(mouse_x, mouse_y)
  center = Vec2D.new(width/2, height/2)
  mouse -= center
  # Multiplying a vector!  The vector is now half its original size (multiplied by 0.5).
  mouse *= 0.5
  translate(width/2, height/2)
  stroke_weight(2)
  stroke(0)
  line(0, 0, mouse.x, mouse.y)
end

def settings
  size 800, 200
  smooth 4
end

