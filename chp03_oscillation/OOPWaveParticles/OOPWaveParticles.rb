# OOPWaveParticles
# The Nature of Code
# http://natureofcode.com

Vect = Struct.new(:x, :y) # no fancy behaviour reqd we can use a struct here

class Particle

  def initialize
    @location = Vect.new(0, 0)
  end

  def set_location(x, y)
    @location.x = x
    @location.y = y
  end

  def display
    fill(rand(255))
    ellipse(@location.x, @location.y, 16, 16)
  end
end

class Wave

  def initialize(o, w_, a, p)
    @origin = o.dup
    @w = w_
    @period = p
    @amplitude = a
    @xspacing = 8
    @dx = (TWO_PI / @period) * @xspacing
    @theta = 0.0
    @particles = Array.new(@w/@xspacing){ Particle.new }
  end

  def calculate
    # Increment theta (try different values for 'angular velocity' here
    @theta += 0.02

    # For every x value, calculate a y value with sine function
    x = @theta
    @particles.each_index do |i|
      @particles[i].set_location(@origin.x+i*@xspacing, @origin.y+sin(x)*@amplitude)
      x += @dx
    end
  end

  def display
    # A simple way to draw the wave with an ellipse at each location
    @particles.each { |p| p.display }
  end
end

def setup
  sketch_title 'Oop Wave Particles'
  # Initialize a wave with starting point, width, amplitude, and period
  @wave0 = Wave.new(Vect.new(200, 75), 100, 20, 500)
  @wave1 = Wave.new(Vect.new(150, 250), 300, 40, 220)
end

def draw
  background(255)

  # Update and display waves
  @wave0.calculate
  @wave0.display

  @wave1.calculate
  @wave1.display
end

def settings
  size(640, 360)
end

