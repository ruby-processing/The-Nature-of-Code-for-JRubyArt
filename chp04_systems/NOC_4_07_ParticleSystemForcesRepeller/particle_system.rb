require 'forwardable'
require_relative 'particle'

module Runnable
  def run
    reject! { |item| item.dead? }
    each    { |item| item.run }
  end
end

class ParticleSystem
  include Enumerable, Runnable
  extend Forwardable
  def_delegators(:@particle_system, :each, :<<, :reject!)


  def initialize(origin)
    @origin = origin
    @particle_system = []
  end

  def add_particle
    self << Particle.new(@origin)
  end

  def apply_force(f)
    each { |p| p.apply_force(f) }
  end

  def apply_repeller(repeller)
    each do |p|
      f = repeller.repel(p)
      p.apply_force(f)
    end
  end
end
