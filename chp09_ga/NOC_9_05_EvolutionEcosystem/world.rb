# Evolution EcoSystem
module Eco
  # A collection of food in the world
  class Food
    include Processing::Proxy
    attr_reader :food, :width, :height

    def initialize(num, width, height)
      @width = width
      @height = height
      @food = []
      num.times do
        food << Vec2D.new(rand(width), rand(height))
      end
    end

    def <<(loc)
      food << loc
    end

    def run
      food.each do |f|
        stroke(0)
        fill(175)
        rect(f.x, f.y, 8, 8)
      end
      food << Vec2D.new(rand(width), rand(height)) if rand < 0.001
    end
  end

  # Creature class
  class Bloop
    include Processing::Proxy
    attr_reader :width, :height, :health, :dna, :location

    def initialize(loc, dna)
      @location = loc.copy
      @health = 200
      @xoff = rand(1_000)
      @yoff = rand(1_000)
      @dna = dna
      @maxspeed = map1d(dna.genes[0], (0..1), (15..0))
      @r = map1d(dna.genes[0], (0..1), (0..50))
      @width = Processing.app.width
      @height = Processing.app.height
    end

    def run
      update
      borders(width, height)
      display
    end

    def eat(f)
      food = f.food
      food.delete_if do |food_loc|
        d = location.dist(food_loc)
        if d < @r / 2.0
          @health += 100
          true
        end
      end
    end

    def reproduce
      return nil if rand >= 0.0005

      child = dna.copy
      child.mutate(0.01)
      Bloop.new(location, child)
    end

    def update
      vx = map1d(noise(@xoff), (-1.0..1.0), (-@maxspeed..@maxspeed))
      vy = map1d(noise(@yoff), (-1.0..1.0), (-@maxspeed..@maxspeed))
      velocity = Vec2D.new(vx, vy)
      @xoff += 0.01
      @yoff += 0.01
      @location += velocity
      @health -= 0.2
    end

    def borders(width, height)
      @location.x = width + @r if location.x < -@r
      @location.y = height + @r if location.y < -@r
      @location.x = -@r if location.x > width + @r
      @location.y = -@r if location.y > height + @r
    end

    def display
      stroke(0, health)
      fill(0, health)
      ellipse(location.x, location.y, @r, @r)
    end

    def dead?
      health < 0
    end
  end

  # DNA class
  class DNA
    attr_reader :genes

    def initialize(newgenes = [])
      newgenes << rand(0..1.0) if newgenes.empty?
      @genes = newgenes
    end

    def copy
      DNA.new(genes.clone)
    end

    # this code doesn't make sense unless there is more than one gene
    def mutate(m)
      @genes.map! { |gene| rand < m ? rand(0..1.0) : gene }
    end
  end

  # The World we live in
  # Has bloops and food
  class World
    attr_reader :bloops, :food

    def initialize(num, width, height)
      @food = Food.new(num, width, height)
      @bloops = []
      num.times do
        loc = Vec2D.new(rand(width), rand(height))
        dna = DNA.new
        bloops << Bloop.new(loc, dna)
      end
    end

    def born(x, y)
      loc = Vec2D.new(x, y)
      dna = DNA.new
      bloops << Bloop.new(loc, dna)
    end

    def run
      food.run

      bloops.each do |b|
        b.run
        b.eat(food)
        child = b.reproduce
        bloops << child if child
      end

      bloops.reject! do |b|
        if b.dead?
          food << b.location
          true
        end
      end
    end
  end
end
