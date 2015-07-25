###Note 10 November 2014


These examples were created for the [pbox2d gem][] version 0.3.0 which is only loosely based on Dan Shiffmans Box2D for processing. The main difference being that parameters are set using hash entry, allowing a more ruby-like experience as with Dan Shiffmans there is incomplete support for jbox2d functionality, but there is scope to extend it.

### Using pbox2d in some more detail
You should have ruby-processing and the pbox2d gem installed, from your processing sketch `require` pbox2d
```ruby
require 'pbox2d'

# A list we'll use to track fixed objects
attr_reader :box2d, :boundaries, :boxes
```
You then need to create an instance of `Box2D` in the setup
```ruby
def setup
  size(400,300)
  @box2d = Box2D.new(self)
  box2d.init_options(gravity: [0, -20])
  box2d.create_world  
  ...
```
Since version 0.2.0 the design of the `pbox2d` is somewhat different from the Dan Shiffman version, to give a cleaner more ruby like experience. Most options can now be set using either `init_options` (`gravity` etc) or `step_options` (`time_step`). Like all good ruby the code says it all, see code below from the Box2D class, where warm stands for `warm_starting` and continuous stands for `continuous_physics` for the sake of brevity:-
```ruby
  def init_options(args = {})
    scale = args[:scale] || 10.0
    gravity = args[:gravity] || [0, -10.0]
    warm = args[:warm] || true
    continuous = args[:continuous] || true
    set_options(scale, gravity.to_java(Java::float), warm, continuous) # java method  
  end

  def step_options(args = {})
    time_step = args[:time_step] || 1.0 / 60
    velocity = args[:velocity_iter] || 8
    position = args[:position_iter] || 10
    set_step(time_step, velocity, position) # java method
  end
```

### From sketch to physics world and vice versa

Because of the peculiar choice by the processing guys down is up (dimensions in pixels) jbox2d doesn't like to live in the pixel world (also up is up), and prefers meters or feet and inches (whatever). Upshot is you need to scale between the two worlds using `world_to_processing` and `processing_to_world` [methods provided][]. You should read the book chapter where Dan explains it all, albeit with slightly different method names.

### Custom ContactListener

See `collision_listening.rb` example for how to implement a java interface, by just including it as if it were a module

[example sketches]:https://github.com/ruby-processing/jbox2d/blob/master/examples/
[methods provided]:https://github.com/ruby-processing/jbox2d/blob/master/ext/processing/box2d/Box2DProcessing.java
[pbox2d gem]:https://github.com/ruby-processing/jbox2d
