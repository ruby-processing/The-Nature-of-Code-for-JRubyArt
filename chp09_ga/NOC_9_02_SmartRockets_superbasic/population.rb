# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com
# Pathfinding w/ Genetic Algorithms

# A class to describe a population of "creatures"
class Population
  include Processing::HelperMethods
  attr_reader :mutation_rate, :population, :mating_pool, :generations, :width, :height, :target

  # Initialize the population
  def initialize(m, num, width, height, target)
    @mutation_rate, @width, @height, @target = m, width, height, target
    # Array.new(num, Rocket.new)
    @mating_pool = []
    @generations = 0
    # make a new set of creatures
    @population = (0..num).map { Rocket.new(Vec2D.new(width / 2, height + 20), DNA.new(height), target) }
  end

  def live
    # Run every rocket
    population.each(&:run)
  end

  # Calculate fitness for each creature
  def fitness
    population.each(&:fitness)
  end

  # Generate a mating pool
  def selection
    # Clear the ArrayList
    mating_pool.clear

    # Calculate total fitness of whole population
    max_fit = max_fitness

    # Calculate fitness for each member of the population (scaled to value between 0 and 1)
    # Based on fitness, each member will get added to the mating pool a certain number of times
    # A higher fitness = more entries to mating pool = more likely to be picked as a parent
    # A lower fitness = fewer entries to mating pool = less likely to be picked as a parent
    population.length.times do |i|
      fitness_normal = map1d(population[i].fitness, (0..max_fit), (0..1))
      n = (fitness_normal * 100).to_i  # Arbitrary multiplier
      n.times { mating_pool << population[i] }
    end
  end

  # Making the next generation
  def reproduction
    # Refill the population with children from the mating pool
    population.length.times do |i|
      # Sping the wheel of fortune to pick two parents
      m = rand(mating_pool.length)
      d = rand(mating_pool.length)
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
      population[i] = Rocket.new(Vec2D.new(width / 2, height + 20), child, target)
    end
    @generations += 1
  end

  # Find highest fintess for the population
  def max_fitness
    population.max_by(&:fitness).fitness
  end
end
