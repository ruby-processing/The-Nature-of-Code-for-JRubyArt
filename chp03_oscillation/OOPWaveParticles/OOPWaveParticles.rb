# OOPWaveParticles
# The Nature of Code
# http://natureofcode.com
class Particle
  attr_reader :location

  def initialize(location:)
    @location = location
  end

  def new_location(position:)
    @location = position
  end

  def display
    fill(rand(255))
    ellipse(location.x, location.y, 16, 16)
  end
end

Vect = Struct.new(:x, :y) # no fancy behaviour reqd we can use a struct here

# The Wave class
class Wave
  attr_reader :origin

  def initialize(origin:, width:, amplitude:, period:)
    @origin = origin
    @w = width
    @period = period
    @amplitude = amplitude
    @xspacing = 8
    @dx = (TWO_PI / @period) * @xspacing
    @theta = 0.0
    @particles = (0..@w / @xspacing).map { Particle.new(location: Vec2D.new) }
  end

  def calculate
    # Increment theta (try different values for 'angular velocity' here
    @theta += 0.02
    # For every x value, calculate a y value with sine function
    x = @theta
    @particles.each_index do |i|
      @particles[i].new_location(
        position: Vec2D.new(
          origin.x + i * @xspacing,
          origin.y + sin(x) * @amplitude
        )
      )
      x += @dx
    end
  end

  def display
    # A simple way to draw the wave with an ellipse at each location
    @particles.each(&:display)
  end
end

attr_reader :waves

def setup
  sketch_title 'OO Wave Particles'
  wave0 = Wave.new(
    origin: Vect.new(200, 75),
    width: 100,
    amplitude: 20,
    period: 500
  )
  wave1 = Wave.new(
    origin: Vect.new(150, 250),
    width: 300,
    amplitude: 40,
    period: 220
  )
  @waves = [wave0, wave1]
end

def draw
  background(255)
  # Update and display waves
  waves.each do |wave|
    wave.calculate
    wave.display
  end
end

def settings
  size(640, 360)
end
