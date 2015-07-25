# NOC_4_06_ParticleSystemForces

require_relative 'particle_system'
attr_reader :ps

def setup
  sketch_title 'Noc 4 06 Particle System Forces'
  @ps = ParticleSystem.new(Vec2D.new(width / 2, 50))
end

def draw
  background(255)
  # Apply gravity force to all Particles
  gravity = Vec2D.new(0, 0.1)
  ps.apply_force(gravity)
  ps.add_particle
  ps.run
end

def settings
  size(640,360)
end

