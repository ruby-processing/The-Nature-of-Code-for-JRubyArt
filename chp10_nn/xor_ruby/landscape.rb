# The Nature of Code
# Daniel Shiffman
# https://natureofcode.com

# "Landscape" example
class Landscape
  include Processing::Proxy

  attr_reader :scl, :w, :h, :rows, :cols, :z, :zoff

  def initialize(scl, w, h)
    @scl, @w, @h  = scl, w, h
    @cols = w / scl
    @rows = h / scl
    @z = (0..cols).map do |row|
      (0..rows).map { 0.0 }
    end
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
    # using the propane grid convenience function instead of a nested loop
    grid(z.size - 1, z[0].size - 1) do |x, y|
      # one quad at a time
      # each quad's color is determined by the height value at each vertex
      # (clean this part up)
      no_stroke
      push_matrix
      begin_shape(PConstant::QUADS)
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
