# NOC_4_07_ParticleSystemForcesRepeller
# http://natureofcode.com
require_relative 'repeller'
require_relative 'particle_system'

attr_reader :ps, :repeller

def setup
  sketch_title 'Particle System Forces Repeller'
  @ps = ParticleSystem.new(origin: Vec2D.new(width / 2, 50))
  @repeller = Repeller.new(origin: Vec2D.new(width / 2 - 20, height / 2))
end

def draw
  background(255)
  ps.add_particle
  gravity = Vec2D.new(0, 0.1)
  ps.apply_force(force: gravity)
  ps.apply_repeller(repel: repeller)
  repeller.display
  ps.run
end

def settings
  size(640, 360)
end
