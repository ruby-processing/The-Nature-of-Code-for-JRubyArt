# frozen_string_literal: true

# NOC_2_8_mutual_attraction
# http://natureofcode.com
require_relative 'mover'

def setup
  sketch_title 'Mutual Attraction'
  @movers = (0..19).map do
    Mover.new(
      location: Vec2D.new(rand(width), rand(height)),
      mass: rand(0.1..2)
    )
  end
end

def draw
  background(255)
  @movers.each do |moover|
    @movers.each do |other|
      next if moover.equal? other

      moover.apply_force(force: other.attract(mover: moover))
    end
    moover.run
  end
end

def settings
  size(800, 200)
end
