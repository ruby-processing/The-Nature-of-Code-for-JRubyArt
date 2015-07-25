# Rocket class -- this is just like our Boid / Particle class
# the only difference is that it has DNA & fitness
class Rocket
  include Processing::Proxy
  attr_reader :acceleration, :dna, :hit_target, :stopped, :location, :velocity

  def initialize(l, dna)
    @acceleration = Vec2D.new
    @velocity = Vec2D.new
    @location = l.copy
    @r = 4
    @dna = dna
    @finish_time = 0  # We're going to count how long it takes to reach target
    @record_dist = 10_000      #  Some high number that will be beat instantly
    @gene_counter = 0
    @stopped = false
    @hit_target = false
  end

  # FITNESS FUNCTION
  # distance = distance from target
  # finish = what order did i finish (first, second, etc. . .)
  # f(distance, finish) = (1.0 / finish**1.5) * (1.0 / distance**6)
  # a lower finish is rewarded (exponentially) and/or shorter distance to
  # target (exponetially)
  def fitness
    @record_dist = 1 if @record_dist < 1
    # Reward finishing faster and getting close
    @fitness = (1 / (@finish_time * @record_dist))
    # Make the function exponential
    @fitness **= 4
    @fitness *= 0.1 if stopped       # lose 90% of fitness hitting an obstacle
    @fitness *= 2 if hit_target     # twice the fitness for finishing!
    @fitness
  end

  # Run in relation to all the obstacles
  # If I'm stuck, don't bother updating or checking for intersection
  def run(obstacles)
    unless stopped || hit_target
      apply_force(dna.genes[@gene_counter])
      @gene_counter = (@gene_counter + 1) % dna.genes.size
      update
      # If I hit an edge or an obstacle
      obstacles(obstacles)
    end
    # Draw me
    display unless stopped
  end

  # Did I make it to the target?
  def check_target(target)
    d = location.dist(target.location)
    @record_dist = d if d < @record_dist
    if target.contains(location) && !hit_target
      @hit_target = true
    elsif !hit_target
      @finish_time += 1
    end
  end

  # Did I hit an obstacle?
  def obstacles(obstacles)
    obstacles.each { |o| @stopped = true if o.contains(location) }
  end

  def apply_force(f)
    @acceleration += f
  end

  def update
    @velocity += acceleration
    @location += velocity
    @acceleration *= 0
  end

  def display
    theta = velocity.heading + PI / 2
    fill(200, 100)
    stroke(0)
    stroke_weight(1)
    push_matrix
    translate(location.x, location.y)
    rotate(theta)
    # Thrusters
    rect_mode(CENTER)
    fill(0)
    rect(-@r / 2, @r * 2, @r / 2, @r)
    rect(@r / 2, @r * 2, @r / 2, @r)
    # Rocket body
    fill(175)
    begin_shape(TRIANGLES)
    vertex(0, -@r * 2)
    vertex(-@r, @r * 2)
    vertex(@r, @r * 2)
    end_shape
    pop_matrix
  end
end
