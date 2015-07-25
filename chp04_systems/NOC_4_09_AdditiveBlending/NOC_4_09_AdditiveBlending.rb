#  NOC_4_09_AdditiveBlending
# The Nature of Code
# http://natureofcode.com
require_relative 'particle_system'

attr_reader :ps

def setup
  sketch_title 'Noc 4 09 Additive Blending'
  @ps = ParticleSystem.new(0, Vec2D.new(width / 2, 50))
end

def draw
  blend_mode(ADD)
  background(0)
  ps.run
  10.times{ ps.add_particle }
end

def settings
  size(640, 340, P2D)
end

