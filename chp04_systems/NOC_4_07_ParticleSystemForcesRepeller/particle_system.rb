require 'forwardable'
require_relative 'particle'

module Runnable
  def run
    reject!(&:dead?)
    each(&:run)
  end
end

class ParticleSystem
  include Runnable
  include Enumerable
  extend Forwardable
  def_delegators(:@particle_system, :each, :<<, :reject!)

  def initialize(origin:)
    @origin = origin
    @particle_system = []
  end

  def add_particle
    self << Particle.new(location: @origin)
  end

  def apply_force(force:)
    each { |p| p.apply_force(force: force) }
  end

  def apply_repeller(repel:)
    each do |p|
      f = repel.repel_force(particle: p)
      p.apply_force(force: f)
    end
  end
end
