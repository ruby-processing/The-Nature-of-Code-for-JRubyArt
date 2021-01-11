# The Nature of Code
# NOC_8_07_TreeStochastic
# Stochastic Tree
# Renders a simple tree-like structure via recursion
# Angles and number of branches are rand

def setup
  sketch_title 'Noc 8 07 Tree Stochastic'
  new_tree
end

def draw
  no_loop
end

def mouse_pressed
  new_tree
  redraw
end

def new_tree
  background(255)
  fill(0)
  text('Click mouse to generate a new tree', 10, height - 10)
  stroke(0)
  push_matrix
  # Start the tree from the bottom of the screen
  translate(width / 2, height)
  # Start the recursive branching!
  branch(80)
  pop_matrix
end

def branch(h)
  # thickness of the branch is mapped to its length
  sw = map1d(h, (2..120), (1..5))
  stroke_weight(sw)
  # Draw the actual branch
  line(0, 0, 0, -h)
  # Move along to end
  translate(0, -h)
  # Each branch will be 2/3rds the size of the previous one
  h *= 0.66
  # All recursive functions must have an exit condition!!!!
  # Here, ours is when the length of the branch is 2 pixels or less
  return unless h > 2

  # A rand number of branches
  n = rand(1..4)
  n.times do
    # Picking a rand angle
    theta = rand(-PI / 2..PI / 2)
    push_matrix      # Save the current state of transformation (i.e. where are we now)
    rotate(theta)    # Rotate by theta
    branch(h)        # Ok, now call myself to branch again
    pop_matrix       # Whenever we get back here, we "pop" in order to restore the previous matrix state
  end
end

def settings
  size(800, 200)
end
