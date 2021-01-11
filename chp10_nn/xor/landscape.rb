# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com

# "Landscape" example
class Landscape
  include Processing::Proxy

  attr_reader :scl, :w, :h, :rows, :cols, :z, :zoff

  def initialize(scl, w, h)
    @scl = scl
    @w = w
    @h = h
    @cols = w / scl
    @rows = h / scl
    @z = Array.new(cols, Array.new(rows, 0.0))
    @zoff = 0
  end

  # Calculate height values (based off a neural network)
  def calculate(nn)
    val = lambda do |curr, net, x, y|
      curr * 0.95 + 0.05 * (net.feed_forward([x, y]) * 280.0 - 140.0)
    end
    @z = (0...cols).map do |i|
      (0...rows).map do |j|
        val.call(z[i][j], nn, i * 1.0 / cols, j * 1.0 / cols)
      end
    end
  end

  # Render landscape as grid of quads
  def render
    # Every cell is an individual quad
    # (could use quad_strip here, but produces funny results, investigate this)
    (0...z.size - 1).each do |x|
      (0...z[0].size - 1).each do |y|
        # one quad at a time
        # each quad's color is determined by the height value at each vertex
        # (clean this part up)
        no_stroke
        push_matrix
        begin_shape(QUADS)
        translate(x * scl - w * 0.5, y * scl - h * 0.5, 0)
        fill(z[x][y] + 127, 220)
        vertex(0, 0, z[x][y])
        fill(z[x + 1][y] + 127, 220)
        vertex(scl, 0, z[x + 1][y])
        fill(z[x + 1][y + 1] + 127, 220)
        vertex(scl, scl, z[x + 1][y + 1])
        fill(z[x][y + 1] + 127, 220)
        vertex(0, scl, z[x][y + 1])
        end_shape
        pop_matrix
      end
    end
  end
end
