# NOC_1_3_vector_subtraction.pde
# The Nature of Code
# http://natureofcode.com
# Example 1-3: Vector subtraction

def setup
  sketch_title 'Noc 1 3 Vector Subtraction'
end

def draw
  background(255)
  mouse = Vec2D.new(mouse_x, mouse_y)
  center = Vec2D.new(width / 2, height / 2)
  mouse -= center
  translate(width / 2, height / 2)
  stroke_weight(2)
  stroke(0)
  line(0, 0, mouse.x, mouse.y)
end

def settings
  size(800, 200)
  smooth 4
end

