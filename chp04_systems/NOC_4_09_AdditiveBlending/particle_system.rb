#  NOC_4_09_AdditiveBlending
# The Nature of Code
# http://natureofcode.com

require 'forwardable'
require_relative 'particle'

module Runnable
  def run
    reject!(&:dead?)
    each(&:run)
  end
end

class ParticleSystem
  include Processing::Proxy, Enumerable, Runnable
  extend Forwardable
  def_delegators(:@particles, :reject!, :<<, :each, :empty)
  def_delegator(:@particles, :empty?, :dead?)

  def initialize(number:, origin:)
    @origin = origin
    @img = load_image('texture.png')
    @particles = Array.new(number) { Particle.new(location: @origin, image: @img) }
  end

  def add_particle(p = nil)
    p ||= Particle.new(location: @origin, image: @img)
    self << p
  end
end
