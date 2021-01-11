# NOC_1_4_vector_multiplication
# The Nature of Code
# http://natureofcode.com
# Example 1-4: Vector multiplication
# More cool stuff with Vectors in JRubyArt
# you can multiply a Vec2D with a scalar value

def setup
  sketch_title 'Vector Multiplication'
end

def draw
  background 255
  mouse = Vec2D.new(mouse_x, mouse_y)
  center = Vec2D.new(width / 2, height / 2)
  mouse -= center
  # Multiplying a vector!
  mouse *= 0.5
  translate(width / 2, height / 2)
  stroke_weight(2)
  stroke(0)
  line(0, 0, mouse.x, mouse.y)
end

def settings
  size 800, 200
  smooth 4
end
