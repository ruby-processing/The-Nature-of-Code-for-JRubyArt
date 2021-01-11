# Exercise_3_10_OOPWave
# The Nature of Code
# http://natureofcode.com
Vect = Struct.new(:x, :y) # no functionality required no need for Vec2D here

class Wave
  def initialize(position:, width:, amplitude:, period:)
    @xspacing = 8 # How far apart should each horizontal location be space
    @theta = 0.0
    @origin = position # Where does the wave's first point start
    @w = width         # Width of entire wave
    @period = period   # How many pixels before the wave repeats
    @amplitude = amplitude # Height of wave
    @dx = (TWO_PI / @period) * @xspacing
    # Use an array to store height values for the wave (not really necessary)
    @yvalues = Array.new(@w / @xspacing)
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
  sketch_title 'Exercise OO Wave'
  # Initialize a wave with starting point, width, amplitude, and period
  @wave0 = Wave.new(
    position: Vect.new(50, 75),
    width: 100,
    amplitude: 20,
    period: 500
  )
  @wave1 = Wave.new(
    position: Vect.new(300, 100),
    width: 300,
    amplitude: 40,
    period: 220
  )
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
