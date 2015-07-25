java_import 'java.awt.Rectangle'

# The class Face probably knows too much
class Face
  include Processing::Proxy
  WH = 70
  attr_reader :dna, :x, :y, :r, :rollover_on, :fitness

  # Create a new face
  def initialize(dna, x, y)
    @dna, @x, @y = dna, x, y
    @fitness = 1.0
    # Using java.awt.Rectangle (see: http://java.sun.com/j2se/1.4.2/docs/api/java/awt/Rectangle.html)
    @r = Rectangle.new((x - WH / 2.0).to_i, (y - WH / 2.0).to_i, WH, WH)
  end

  # Display the face
  def display
    # We are using the face's DNA to pick properties for this face
    # such as: head size, color, eye position, etc.
    # Now every gene is a floating point between 0 and 1, we map the values
    ra = map1d(dna.genes[0], (0..1.0), (0..70))
    c = color(dna.genes[1], dna.genes[2], dna.genes[3])
    eye_y = map1d(dna.genes[4], (0..1.0), (0..5))
    eye_x = map1d(dna.genes[5], (0..1.0), (0..10))
    eye_size = map1d(dna.genes[5], (0..1.0), (0..10))
    eyecolor = color(dna.genes[4], dna.genes[5], dna.genes[6])
    mouth_color = color(dna.genes[7], dna.genes[8], dna.genes[9])
    mouth_y = map1d(dna.genes[5], (0..1.0), (0..25))
    mouth_x = map1d(dna.genes[5], (0..1.0), (-25..25))
    mouthw = map1d(dna.genes[5], (0..1.0), (0..50))
    mouthh = map1d(dna.genes[5], (0..1.0), (0..10))
    # Once we calculate all the above properties, we use those variables to
    # draw rects, ellipses, etc.
    push_matrix
    translate(x, y)
    no_stroke
    # Draw the head
    fill(c)
    ellipse_mode(CENTER)
    ellipse(0, 0, ra, ra)
    # Draw the eyes
    fill(eyecolor)
    rect_mode(CENTER)
    rect(-eye_x, -eye_y, eye_size, eye_size)
    rect(eye_x, -eye_y, eye_size, eye_size)
    # Draw the mouth
    fill(mouth_color)
    rect_mode(CENTER)
    rect(mouth_x, mouth_y, mouthw, mouthh)
    # Draw the bounding box
    stroke(0.25)
    rollover_on ? fill(0, 0.25) : no_fill
    rect_mode(CENTER)
    rect(0, 0, WH, WH)
    pop_matrix
    # Display fitness value
    textAlign(CENTER)
    rollover_on ? fill(0) : fill(0.25)
    text(format('%d', fitness.to_i), x, y + 55)
  end

  # Increment fitness if mouse is rolling over face
  def rollover(mx, my)
    if r.contains(mx, my)
      @rollover_on = true
      @fitness += 0.25
    else
      @rollover_on = false
    end
  end
end
