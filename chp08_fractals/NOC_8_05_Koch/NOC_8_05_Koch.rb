# The Nature of Code
# NOC_8_05_Koch
class KochLine
  include Processing::Proxy
  attr_reader :start, :finish

  def initialize(start:, finish:)
    @start = start
    @finish = finish
  end

  def display
    stroke(120)
    line(start.x, start.y, finish.x, finish.y)
  end

  # This is easy, just 1/3 of the way
  def kochleft
    v = finish - start
    v /= 3
    v + start
  end

  # Using a little trig to figure out where this vector is!
  def kochmiddle
    v = finish - start
    v /= 3
    p = start.copy
    p += v
    rotate_line(v, -60)
    p + v
  end

  # Easy, just 2/3 of the way
  def kochright
    v = start - finish
    v /= 3
    v + finish
  end

  private

  def rotate_line(v, theta)
    xtemp = v.x
    v.x = v.x * cos(theta.radians) - v.y * sin(theta.radians)
    v.y = xtemp * sin(theta.radians) + v.y * cos(theta.radians)
  end
end

class KochFractal
  attr_reader :count, :start, :finish, :lines
  def initialize(start:, finish:)
    @start = start
    @finish = finish
    @lines = []
    restart
  end

  def next_level
    # For every line that is in the arraylist
    # create 4 more lines in a new arraylist
    @lines = iterate(lines)
    @count += 1
  end

  def restart
    @count = 0      # Reset count
    lines.clear     # Empty the array list
    # Add the initial line (from one end vector to the other)
    lines << KochLine.new(start: start, finish: finish)
  end

  def render
    lines.each(&:display)
  end

  # This is where the **MAGIC** happens
  # Step 1: Create an empty arraylist
  # Step 2: For every line currently in the arraylist
  #   - calculate 4 line segments based on Koch algorithm
  #   - add all 4 line segments into the new arraylist
  # Step 3: Return the new arraylist and it becomes the list of line segments
  #         for the structure

  # As we do this over and over again, each line gets broken into 4 lines,
  # which gets broken into 4 lines, and so on. . .
  def iterate(before)
    now = []    # Create empty list
    before.each do |l|
      # Calculate 5 koch vectors (done for us by the line object)
      a = l.start
      b = l.kochleft
      c = l.kochmiddle
      d = l.kochright
      e = l.finish
      # Make line segments between all the vectors and add them
      now << KochLine.new(start: a, finish: b)
      now << KochLine.new(start: b, finish: c)
      now << KochLine.new(start: c, finish: d)
      now << KochLine.new(start: d, finish: e)
    end
    now
  end
end

attr_reader :koch

def setup
  sketch_title 'Koch'
  background(255)
  frame_rate(1)  # Animate slowly
  @koch = KochFractal.new(
    start: Vec2D.new(0, height - 20),
    finish: Vec2D.new(width, height - 20)
  )
end

def draw
  background(255)
  # Draws the snowflake!
  koch.render
  # Iterate
  koch.next_level
  # Let's not do it more than 5 times. . .
  koch.restart if koch.count > 5
end

def settings
  size(800, 250)
  smooth 8
end
