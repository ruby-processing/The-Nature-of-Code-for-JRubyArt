# A class to describe a population of "creatures"
class Population
  include Processing::HelperMethods
  attr_reader :generations, :width, :height

  def initialize(m, num, width, height)
    @mutation_rate = m
    @population = Array.new(num) do
      location = Vec2D.new(width / 2, height + 20)
      Rocket.new(location, DNA.new)
    end
    @mating_pool = []
    @generations = 0
    # don't want to keep these, but needed in the reproduction cycle
    @width = width
    @height = height
  end

  def live(obstacles, target)
    # For every creature
    @population.each do |p|
      p.check_target(target)
      p.run(obstacles)
    end
  end

  # Did anything finish?
  def target_reached
    @population.any?(&:hit_target)
  end

  # Calculate fitness for each creature
  def fitness
    @population.each(&:fitness)
  end

  # Generate a mating pool
  def selection
    # Clear the ArrayList
    @mating_pool.clear
    # Calculate total fitness of whole population
    max_fitness = @population.max_by(&:fitness).fitness
    # Calculate fitness for each member of the population (scaled to value
    # between 0 and 1). Based on fitness, each member will get added to the
    # mating pool a certain number of times. A higher fitness = more entries
    # to mating pool = more likely to be picked as a parent.  A lower fitness
    # = fewer entries to mating pool = less likely to be picked as a parent
    @population.each do |p|
      fitness_normal = map1d(p.fitness, (0..max_fitness), (0..1.0))
      (fitness_normal * 100).to_i.times { @mating_pool << p }
    end
  end

  # Making the next generation
  def reproduction
    # Refill the population with children from the mating pool
    @population.each_index do |i|
      # Sping the wheel of fortune to pick two parents
      m = rand(@mating_pool.size).to_i
      d = rand(@mating_pool.size).to_i
      # Pick two parents
      mom = @mating_pool[m]
      dad = @mating_pool[d]
      # Get their genes
      momgenes = mom.dna
      dadgenes = dad.dna
      # Mate their genes
      child = momgenes.crossover(dadgenes)
      # Mutate their genes
      child.mutate(@mutation_rate)
      # Fill the new population with the new child
      location = Vec2D.new(width / 2, height + 20)
      @population[i] = Rocket.new(location, child)
    end
    @generations += 1
  end
end
