# The Nature of Code
# NOC_8_01_Recursion
def setup
  sketch_title 'Recursion'
end

def draw
  background(255)
  draw_circle(width / 2, height / 2, width)
  no_loop
end

# Very simple function that draws one circle
# and recursively calls itself
def draw_circle(x, y, r)
  ellipse(x, y, r, r)
  # Exit condition, stop when radius is too small
  return unless r > 2

  r *= 0.75
  # Call the function inside the function! (recursion!)
  draw_circle(x, y, r)
end

def settings
  size(640, 360)
end
