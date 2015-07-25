# NOC_4_08_ParticleSystemSmoke_b
# The Nature of Code
# http://natureofcode.com

require 'forwardable'
require_relative 'particle'

module Runnable
  def run
    reject! { |item| item.lifespan <= 0 }
    each    { |item| item.run }
  end
end

class ParticleSystem
  include Enumerable, Runnable
  extend Forwardable
  def_delegators(:@particles, :reject!, :<<, :each, :empty?)
  def_delegator(:@particles, :empty?, :dead?)

  def initialize(num, origin, img)
    @origin = origin.copy
    @img = img
    # avoid confusion with ruby Random
    @generator = Java::JavaUtil::Random.new
    @particles = Array.new(num) { create_particle }
  end

  def add_particle(particle = nil)
    particle ||= create_particle
    self << particle
  end

  def apply_force(f)
    each { |p| p.apply_force(f) }
  end

  private

  def create_particle
    vx = @generator.next_gaussian * 0.3
    vy = @generator.next_gaussian * 0.3 - 1
    vel = Vec2D.new(vx, vy)
    Particle.new(@origin, vel, @img)
  end
end


