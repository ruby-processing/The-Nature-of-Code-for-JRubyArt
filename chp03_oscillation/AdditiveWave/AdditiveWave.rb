# AdditiveWave
# The Nature of Code
# http://natureofcode.com

# Additive Wave
# Create a more complex wave by adding two waves together.

# Maybe better for this answer to be OOP???

def setup
  sketch_title 'Additive Wave'
  colorMode(RGB, 255, 255, 255, 100)
  @w = width + 16
  @xspacing = 8
  @maxwaves = 5
  @theta = 0.0
  @amplitudes = Array.new(@maxwaves){ rand(10 ..  30) }
  @dx = Array.new(@maxwaves) do |i|
    period = rand(100, 300)
    (TWO_PI / period) * @xspacing
  end

  @yvalues = Array.new(@w/@xspacing)
end

def draw
  background(0)
  calc_wave
  render_wave
end

def calc_wave
  # Increment theta (try different values for 'angular velocity' here
  @theta += 0.02

  # Set all height values to zero
  @yvalues.each{ |yvalue| yvalue = 0 }

  # Accumulate wave height values
  (0...@maxwaves).each do |j|
    x = @theta
    @yvalues.each_index do |i|
      j % 2 == 0 ? @yvalues[i] = sin(x)*@amplitudes[j] : @yvalues[i] = cos(x) * @amplitudes[j]
      x += @dx[j]
    end
  end
end

def render_wave
  # A simple way to draw the wave with an ellipse at each location
  no_stroke
  fill(255, 50)
  ellipse_mode(CENTER)
  @yvalues.each_with_index do |yvalue, x|
    ellipse(x*@xspacing, height/2+yvalue, 16, 16)
  end
end

def settings
  size(640, 360)
end

