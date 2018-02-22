# NOC_3_09_wave
def setup
  sketch_title 'Noc 3 09 Wave'
  @start_angle = 0
  @angle_vel = 0.23
end

def draw
  background(255)

  @start_angle += 0.015
  angle = @start_angle

  (0..width).step(24) do |x|
    y = map1d(sin(angle), (-1..1), (0..height))
    stroke(0)
    fill(0, 50)
    stroke_weight(2)
    ellipse(x, y, 48, 48)
    angle += @angle_vel
  end
end

def settings
  size(800, 200)
  smooth
end

