require 'pbox2d'
require_relative 'lib/particle_system'
attr_reader :box2d, :boundaries, :systems

def setup
  sketch_title 'Liquidy'
  @box2d = Box2D.new(self)
  box2d.init_options(gravity: [0, -20])
  box2d.create_world
  # to set a custom gravity otherwise
  # box2d.gravity([0, -20])
  # Create Arrays
  @systems = []
  @boundaries = []
  # Add a bunch of fixed boundaries
  boundaries << Boundary.new(box2d, 50, 100, 300, 5, -0.3)
  boundaries << Boundary.new(box2d, 250, 175, 300, 5, 0.5)
end

def draw
  background(255)
  # Run all the particle systems
  if systems.size > 0
    systems.each do |system|
      system.run
      system.add_particles(box2d, rand(0..2))
    end
  end
  # Display all the boundaries
  boundaries.each(&:display)
end

def mouse_pressed
  # Add a new Particle System whenever the mouse is clicked
  systems << ParticleSystem.new(box2d, 0, mouse_x, mouse_y)
end

def settings
  size(400,300)
end
