# NOC_3_05_simple_harmonic_motion
# The Nature of Code
# http://natureofcode.com

def setup
  sketch_title 'Simple Harmonic Motion'
end

def draw
  background 255
  period = 120
  amplitude = 300
  # Calculating horizontal location according to formula for simple harmonic motion
  x = amplitude * cos(TAU * frame_count / period)
  stroke(0)
  stroke_weight(2)
  fill(127)
  translate(width / 2, height / 2)
  line(0, 0, x, 0)
  ellipse(x, 0, 48, 48)
end

def settings
  size 800, 200
end
