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

  attr_reader :origin

  def initialize(origin:)
    @origin = origin
    @particle_system = []
  end

  def add_particle
    self << Particle.new(location: origin)
  end

  def apply_force(force:)
    each { |p| p.apply_force(force: force) }
  end
end
