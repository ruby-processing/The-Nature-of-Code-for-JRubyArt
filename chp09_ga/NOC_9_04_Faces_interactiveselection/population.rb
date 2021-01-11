# This population class probably knows too much
class Population
  include Processing::Proxy
  attr_reader :mutation_rate, :population, :mating_pool, :generations

  # Create the population
  def initialize(m, num)
    @mutation_rate = m
    @mating_pool = []
    @generations = 0
    @population = (0...num).map do |i|
      Face.new(DNA.new, 50 + i * 75, 60)
    end
  end

  # Display all faces
  def display
    population.each(&:display)
  end

  # Are we rolling over any of the faces?
  def rollover(mx, my)
    population.each { |pop| pop.rollover(mx, my) }
  end

  # Generate a mating pool
  def selection
    # Clear the ArrayList
    mating_pool.clear
    # Calculate total fitness of whole population
    max = max_fitness
    # Fitness for each member of the population (scaled to between 0 and 1)
    # Members get added to the mating pool a number of times based on fitness
    # A higher fitness = more entries to mating pool
    # A lower fitness = fewer entries to mating pool
    population.each do |pop|
      fitness_normal = map1d(pop.fitness, (0..max), (0..1.0))
      n = (fitness_normal * 100).to_i # Arbitrary multiplier
      (n - 1).times do
        mating_pool << pop
      end
    end
  end

  # Making the next generation
  def reproduction
    # Refill the population with children from the mating pool
    population.length.times do |i|
      # Sping the wheel of fortune to pick two parents
      m = rand(0..mating_pool.length)
      d = rand(0..mating_pool.length)
      # Pick two parents
      mom = mating_pool[m]
      dad = mating_pool[d]
      # Get their genes
      momgenes = mom.dna
      dadgenes = dad.dna
      # Mate their genes
      child = momgenes.crossover(dadgenes)
      # Mutate their genes
      child.mutate(mutation_rate)
      # Fill the new population with the new child
      population[i] = Face.new(child, 50 + i * 75, 60)
    end
    @generations += 1
  end

  # Find highest fitness for the population
  def max_fitness
    population.max_by(&:fitness).fitness
  end
end

# Interactive Selection
# http://www.genarts.com/karl/papers/siggraph91.html
class DNA
  # The genetic sequence
  LEN = 20 # Arbitrary length
  attr_reader :genes

  # Constructor (makes a random DNA)
  def initialize(genes = nil)
    @genes = genes.nil? ? (0..LEN).map { rand(0..1.0) } : genes
  end

  # Crossover
  # Creates new DNA sequence from two (this &
  def crossover(partner)
    child = Array.new(genes.length, 0.0)
    crossover = rand(0..genes.length)
    genes.length.times do |i|
      child[i] = i > crossover ? genes[i] : partner.genes[i]
    end
    DNA.new(child)
  end

  # Based on a mutation probability, picks a new random character in array spots
  def mutate(m)
    genes.length.times do |i|
      genes[i] = rand(0..1.0) if rand < m
    end
  end
end
