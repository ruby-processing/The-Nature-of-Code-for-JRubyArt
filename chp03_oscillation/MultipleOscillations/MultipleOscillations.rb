# MultipleOscillations
# The Nature of Code
# http://natureofcode.com
attr_reader :angle1, :angle2, :velocity1, :velocity2

def setup
  sketch_title 'Multiple Oscillations'
  @angle1 = 0
  @velocity1 = 0.01
  @amplitude1 = 300
  @angle2 = 0
  @velocity2 = 0.3
  @amplitude2 = 10
end

def draw
  background(255)
  x = 0
  x += @amplitude1 * cos(angle1)
  x += @amplitude2 * sin(angle2)
  @angle1 += velocity1
  @angle2 += velocity2
  ellipse_mode(CENTER)
  stroke(0)
  fill(175)
  translate(width / 2, height / 2)
  line(0, 0, x, 0)
  ellipse(x, 0, 20, 20)
end

def settings
  size 640, 360
end
