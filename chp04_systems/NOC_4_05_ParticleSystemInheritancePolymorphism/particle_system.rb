require_relative 'particle'
require 'forwardable'

module Runnable
  def run
    reject!(&:dead?)
    each(&:run)
  end
end

class ParticleSystem
  extend Forwardable
  def_delegators(:@particles, :reject!, :<<, :each)
  include Enumerable, Runnable

  def initialize(origin:)
    @origin = origin
    @particles = []
  end

  def add_particle
    part = (rand < 0.5) ? Particle.new(location: @origin) : Confetti.new(location: @origin)
    self << part
  end
end
