# The Nature of Code
# http://natureofcode.com

def setup
  sketch_title 'Exercise Baton'
  @angle = 0
end

def draw
  background(255)
  fill(127)
  stroke(0)
  rect_mode(CENTER)
  translate(width / 2, height / 2)
  rotate(@angle)
  line(-50, 0, 50, 0)
  stroke(0)
  stroke_weight(2)
  fill(127)
  ellipse(50, 0, 16, 16)
  ellipse(-50, 0, 16, 16)
  @angle += 0.05
end

def settings
  size(750, 150)
  smooth
end
