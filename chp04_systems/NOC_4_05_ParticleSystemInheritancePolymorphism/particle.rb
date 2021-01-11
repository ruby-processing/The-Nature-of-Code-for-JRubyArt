# NOC_4_05_ParticleSystemInheritancePolymorphism
# The Nature of Code
# http://natureofcode.com
require_relative 'particle_system'
require_relative 'particle'

class Particle
  include Processing::Proxy
  attr_reader :acceleration, :lifespan, :location, :velocity

  def initialize(location:)
    @acceleration = Vec2D.new(0, 0.05)
    @velocity = Vec2D.new(rand(-1.0..1), rand(-1..0))
    @location = location
    @lifespan = 255.0
  end

  def run
    update
    display
  end

  # Method to update location
  def update
    @velocity += @acceleration
    @location += @velocity
    @lifespan -= 2.0
  end

  # Method to display
  def display
    stroke(0, @lifespan)
    stroke_weight(2)
    fill(127, @lifespan)
    ellipse(@location.x, @location.y, 12, 12)
  end

  # Is the particle still useful?
  def dead?
    @lifespan < 0.0
  end
end

class Confetti < Particle
  # NB: inherits initialize from Particle no need for super here

  def display
    rect_mode(CENTER)
    fill(127, lifespan)
    stroke(0, lifespan)
    stroke_weight(2)
    push_matrix
    translate(location.x, location.y)
    theta = map1d(location.x, (0..640), (0..TAU * 2))
    rotate(theta)
    rect(0, 0, 12, 12)
    pop_matrix
  end
end

def setup
  sketch_title 'Particle'
  @particle_system = ParticleSystem.new(origin: Vec2D.new(width / 2, 50))
end

def draw
  background(255)
  @particle_system.add_particle
  @particle_system.run
end

def settings
  size(640, 360)
end
