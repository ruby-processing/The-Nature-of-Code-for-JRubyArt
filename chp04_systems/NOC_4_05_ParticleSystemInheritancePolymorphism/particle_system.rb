require_relative 'particle'
require 'forwardable'

module Runnable
  def run
    reject! { |item| item.dead? }
    each    { |item| item.run }
  end
end

class ParticleSystem
  extend Forwardable
  def_delegators(:@particles, :reject!, :<<, :each)
  include Enumerable, Runnable

  def initialize(origin)
    @origin = origin
    @particles = []
  end

  def add_particle
    part = (rand < 0.5) ? Particle.new(@origin) : Confetti.new(@origin)
    self << part
  end
end
