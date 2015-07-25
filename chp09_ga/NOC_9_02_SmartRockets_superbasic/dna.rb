# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com

# DNA is an array of vectors
class DNA
  include Math
  # The maximum strength of the forces
  MAX_FORCE = 0.1
  TWO_PI = PI * 2
  attr_reader :genes, :lifetime

  # Constructor (makes a DNA of random PVectors)
  def create_genes(lftm)
    @genes = (0...lftm).map do
      angle = rand(TWO_PI)
      Vec2D.new(cos(angle), sin(angle)) * rand(0..MAX_FORCE)
    end
  end

  # Constructor #2, creates the instance based on an existing array
  def initialize(lifetime, newgenes = nil)
    @lifetime = lifetime
    # We could make a copy if necessary
    # genes = (PVector []) newgenes.clone();
    @genes = newgenes.nil? ? create_genes(lifetime) : newgenes.clone
  end

  # CROSSOVER
  # Creates new DNA sequence from two (this & and a partner)
  def crossover(partner)
    child = Array.new(genes.length, Vec2D.new)
    # Pick a midpoint
    crossover = rand(genes.length)
    # Take "half" from one and "half" from the other
    genes.length.times do |i|
      child[i] = (i > crossover) ? genes[i] : partner.genes[i]
    end
    DNA.new(lifetime, child)
  end

  # Based on a mutation probability, picks a new random Vector
  def mutate(m)
    genes.length.times do |i|
      if rand < m
        angle = rand(TWO_PI)
        genes[i] = Vec2D.new(cos(angle), sin(angle)) * rand(0..MAX_FORCE)
      end
    end
  end
end
