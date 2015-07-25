# Exercise_2_10_attractrepel
# The Nature of Code
# http://natureofcode.com


require_relative 'attractor'
require_relative 'mover'

G = 1 # kind of pointless gravitational constant

def setup
  sketch_title 'Exercise 2 10 Attractrepel'
  @attractor = Attractor.new(width, height)
  @movers = Array.new(20) {
                            Mover.new(
                                      rand(4.0 .. 12),
                                      rand(width.to_f),
                                      rand(height.to_f)
                                     )
                           }
end

def draw
  background(255)
  @attractor.display
  @movers.each do |m|
    @movers.each do |mm|
      next if m.equal? mm
      force = mm.repel(m)
      m.apply_force(force)
    end
    force = @attractor.attract(m)
    m.apply_force(force)
    m.update
    m.display
  end
end

def settings
  size(800, 200)
end

