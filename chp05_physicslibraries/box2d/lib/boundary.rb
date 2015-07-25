CENTER ||= Java::ProcessingCore::PConstants::CENTER
# The boundary class is used to create a floor in this
# sketch. Note it does not have a change method
class Boundary
  attr_reader :box2d, :x, :y, :w, :h, :b
  def initialize(b2d, x, y, w, h)
    @box2d, @x, @y, @w, @h = b2d, x, y, w, h
    sd = PolygonShape.new
    box2d_w = box2d.scale_to_world(w / 2)
    box2d_h = box2d.scale_to_world(h / 2)
    sd.set_as_box(box2d_w, box2d_h)
    # Create the body
    bd = BodyDef.new
    bd.type = BodyType::STATIC
    bd.position.set(box2d.processing_to_world(x, y))
    @b = box2d.create_body(bd)
    # Attached the shape to the body using a Fixture
    b.create_fixture(sd, 1)
    b.set_user_data(self)
  end

  # Draw the boundary, if it were at an angle we'd have to do something fancier
  def display(app)
    app.fill(0)
    app.stroke(0)
    app.rect_mode(CENTER)
    app.rect(x, y, w, h)
  end
end
