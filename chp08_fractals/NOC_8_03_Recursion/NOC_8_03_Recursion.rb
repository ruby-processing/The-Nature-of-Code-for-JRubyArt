# The Nature of Code
# NOC_8_03_Recursion
def setup
  sketch_title 'Recursion'
end

def draw
  background(255)
  draw_circle(width / 2, height / 2, 400)
  no_loop
end

# Very simple function that draws one circle
# and recursively calls itself
def draw_circle(x, y, r)
  stroke(0)
  no_fill
  ellipse(x, y, r, r)
  # Exit condition, stop when radius is too small
  return unless r > 8

  # now we draw 2 circles, 1 on the left, 1 on the right
  draw_circle(x + r / 2, y, r / 2)
  draw_circle(x - r / 2, y, r / 2)
  draw_circle(x, y + r / 2, r / 2)
  draw_circle(x, y - r / 2, r / 2)
end

def settings
  size(640, 360)
end
