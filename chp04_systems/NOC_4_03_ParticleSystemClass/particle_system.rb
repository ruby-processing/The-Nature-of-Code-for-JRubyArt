# NOC_4_03_ParticleSystemClass
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
  def_delegators(:@particles, :reject!, :<<, :each)
  attr_reader :origin

  def initialize(origin:)
    @origin = origin
    @particles = []
  end

  def add_particle
    self << Particle.new(location: origin)
  end
end
