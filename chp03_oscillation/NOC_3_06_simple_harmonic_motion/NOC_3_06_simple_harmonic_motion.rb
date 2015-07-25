# NOC_3_06_simple_harmonic_motion

attr_reader :angle, :velocity
def setup
  sketch_title 'Noc 3 06 Simple Harmonic Motion'
  @angle = 0
  @velocity = 0.03
end

def draw
  background 255
  amplitude = 300
  x = amplitude * cos(angle)
  @angle += velocity
  ellipse_mode(CENTER)
  stroke 0
  fill 175
  translate(width / 2, height / 2)
  line(0, 0, x, 0)
  ellipse(x, 0, 20, 20)
end

def settings
  size 640, 360
  smooth 4
end

