# We only need to include Math module
class DNA
  include Math
  TWO_PI = PI * 2
  attr_reader :genes
  # Constructor (makes a DNA of rand Vectors)
  def initialize(newgenes = nil)
    @maxforce = 0.1
    @lifetime = 400
    if newgenes
      @genes = newgenes
    else
      @genes = Array.new(@lifetime) do
        angle = rand(TWO_PI)
        gene = Vec2D.new(cos(angle), sin(angle))
        gene *= rand(0...@maxforce)
        gene
      end
    end
    # Let's give each Rocket an extra boost of strength for its first frame
    @genes[0].normalize!
  end

  # CROSSOVER
  # Creates new DNA sequence from two (this & and a partner)
  def crossover(partner)
    child = Array.new(@genes.size)
    # Pick a midpoint
    crossover = rand(genes.length).to_i
    # Take "half" from one and "half" from the other
    @genes.each_with_index do |g, i|
      if i > crossover
        child[i] = g
      else
        child[i] = partner.genes[i]
      end
    end
    DNA.new(child)
  end

  # Based on a mutation probability, picks a new rand Vector
  def mutate(m)
    @genes.length.times do |i|
      next unless rand < m
      angle = rand(TWO_PI)
      @genes[i] = Vec2D.new(cos(angle), sin(angle))
      @genes[i] *= rand(0...@maxforce)
    end
    @genes[0].normalize!
  end
end
