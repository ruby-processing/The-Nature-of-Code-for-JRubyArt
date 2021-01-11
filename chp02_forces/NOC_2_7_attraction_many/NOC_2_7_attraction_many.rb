# frozen_string_literal: true

# NOC_2_7_attraction_many
require_relative 'mover'
require_relative 'attractor'

def setup
  sketch_title 'Attractor Many'
  @movers = (0..9).map do
    Mover.new(
      location: Vec2D.new(rand(width), rand(height)),
      mass: rand(0.1..2)
    )
  end
  @attractor = Attractor.new(location: Vec2D.new(width / 2, height / 2))
end

def draw
  background(255)
  @attractor.display
  @attractor.drag(position: Vec2D.new(mouse_x, mouse_y))
  @attractor.hover(position: Vec2D.new(mouse_x, mouse_y))
  @movers.each do |m|
    m.apply_force(force: @attractor.attract(mover: m))
    m.update
    m.display
  end
end

def mouse_pressed
  @attractor.clicked(position: Vec2D.new(mouse_x, mouse_y))
end

def mouse_released
  @attractor.stop_dragging
end

def settings
  size(640, 360)
end
