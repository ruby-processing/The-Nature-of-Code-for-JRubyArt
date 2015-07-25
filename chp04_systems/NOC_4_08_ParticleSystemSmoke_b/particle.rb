# NOC_4_08_ParticleSystemSmoke_b
# The Nature of Code
# http://natureofcode.com

class Particle
  include Processing::Proxy
  attr_reader :lifespan
  def initialize(loc, vel, img)
    @loc = loc.copy
    @img = img
    @vel = vel
    @acc = Vec2D.new
    @lifespan = 100
  end

  def run
    update
    render
  end

  def apply_force(force)
    @acc += force
  end

  def update
    @vel += @acc
    @loc += @vel
    @lifespan -= 2.5
    @acc *= 0
  end

  def render
    image_mode(CENTER)
    tint(255, lifespan)
    image(@img, @loc.x, @loc.y)
    # Drawing a circle instead
    # fill(255, @lifespan)
    # no_stroke
    # ellipse(@loc.x, @loc.y, 10, 10)
  end

  def dead?
    lifespan <= 0.0
  end
end



