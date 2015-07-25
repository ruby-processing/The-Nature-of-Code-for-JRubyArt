# The Nature of Code
# NOC_8_04_Tree
def setup
  sketch_title 'Noc 8 04 Tree'
  @theta
end

def draw
  background(255)
  # Let's pick an angle 0 to 90 degrees based on the mouse position
  @theta = map1d(mouse_x, (0 .. width), (0 .. PI / 2))

  # Start the tree from the bottom of the screen
  translate(width/2, height)
  stroke(0)
  branch(60)
end

def branch(len)
  # Each branch will be 2/3rds the size of the previous one
  sw = map1d(len, (2 .. 120), (1 .. 10))
  stroke_weight(sw)
  line(0, 0, 0, -len)
  # Move to the end of that line
  translate(0, -len)
  len *= 0.66
  # All recursive functions must have an exit condition!!!!
  # Here, ours is when the length of the branch is 2 pixels or less
  return unless len > 2
  push_matrix    # Save the current state of transformation (i.e. where are we now)
  rotate(@theta) # Rotate by theta
  branch(len)    # Ok, now call myself to draw two new branches!!
  pop_matrix     # Whenever we get back here, we "pop" in order to restore the previous matrix state
  # Repeat the same thing, only branch off to the "left" this time!
  push_matrix
  rotate(-@theta)
  branch(len)
  pop_matrix
end

def settings
  size(300, 200)
  smooth 4
end

