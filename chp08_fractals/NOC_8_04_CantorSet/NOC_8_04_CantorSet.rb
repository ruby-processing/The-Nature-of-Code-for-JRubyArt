# The Nature of Code
# NOC_8_04_CantorSet
def setup
  sketch_title 'Cantor Set'
  background(255)
  @h = 30
  # Call the recursive function
  cantor(35, 0, 730)
end

def cantor(x, y, len)
  # recursive exit condition
  return unless len >= 1
  # Draw line (as rectangle to make it easier to see)
  no_stroke
  fill(0)
  rect(x, y, len, @h / 3)
  # Go down to next y position
  y += @h
  # Draw 2 more lines 1/3rd the length (without the middle section)
  cantor(x, y, len / 3)
  cantor(x  + len * 2 / 3, y, len / 3)
end

def settings
  size(800, 200)
end
