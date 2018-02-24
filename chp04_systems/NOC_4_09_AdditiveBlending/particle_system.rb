#  NOC_4_09_AdditiveBlending
# The Nature of Code
# http://natureofcode.com

require 'forwardable'
require_relative 'particle'

# The runnable module
module Runnable
  def run
    reject!(&:dead?)
    each(&:run)
  end
end

# The ParticleSystem class doubles as a enumerator and is runnable
class ParticleSystem
  include Processing::Proxy, Enumerable, Runnable
  extend Forwardable
  def_delegators(:@particles, :reject!, :<<, :each, :empty)
  def_delegator(:@particles, :empty?, :dead?)

  attr_reader :img, :origin

  def initialize(number:, origin:, image:)
    @origin = origin
    @img = image
    @particles = (0..number).map { Particle.new(location: origin, image: img) }
  end

  def add_particle(obj = nil)
    obj ||= Particle.new(location: origin, image: img)
    self << obj
  end
end
