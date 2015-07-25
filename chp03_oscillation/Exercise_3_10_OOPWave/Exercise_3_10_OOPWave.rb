# Exercise_3_10_OOPWave
# The Nature of Code
# http://natureofcode.com

Vect = Struct.new(:x, :y) # no fancy functionality required why use PVector?

class Wave

  def initialize(o, w_, a, p)
    @xspacing = 8                         # How far apart should each horizontal location be space
    @theta = 0.0
    @origin = o.dup                       # Where does the wave's first point start
    @w = w_                               # Width of entire wave
    @period = p                           # How many pixels before the wave repeats
    @amplitude = a                        # Height of wave
    @dx = (TWO_PI / @period) * @xspacing  # Value for incrementing X, to be calculated as a function of period and xspacing
    @yvalues = Array.new(@w / @xspacing)  # Using an array to store height values for the wave (not entirely necessary)
  end

  def calculate
    # Increment theta (try different values for 'angular velocity' here
    @theta += 0.02
    # For every x value, calculate a y value with sine function
    x = @theta
    @yvalues.each_index do |i|
      @yvalues[i] = sin(x) * @amplitude
      x += @dx
    end
  end

  def display
    # A simple way to draw the wave with an ellipse at each location
    @yvalues.each_with_index do |yvalue, idx|
      stroke(0)
      fill(0, 50)
      ellipse_mode(CENTER)
      ellipse(@origin.x + idx * @xspacing, @origin.y + yvalue, 48, 48)
    end
  end
end

attr_reader :wave0, :wave1

# Exercise_3_10_OOPWave
def setup
  sketch_title 'Exercise 3 10 Oop Wave'
  # Initialize a wave with starting point, width, amplitude, and period
  @wave0 = Wave.new(Vect.new(50, 75), 100, 20, 500)
  @wave1 = Wave.new(Vect.new(300, 100), 300, 40, 220)
end

def draw
  background(255)
  # Update and display waves
  wave0.calculate
  wave0.display
  wave1.calculate
  wave1.display
end

def settings
  size(750, 200)
end

