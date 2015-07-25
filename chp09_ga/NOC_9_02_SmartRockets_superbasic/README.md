## Example of using refined includes in ruby-processing
In dna.rb, we only require access to ruby math methods so we just `include Math` in the DNA class

In population.rb we want to use the helper method `map1d` so we just `include Processing::HelperMethods` in the Population class

In rocket.rb, we require similar access to processing methods as available to java inner classes, so here we `include Processing::Proxy` this allows us to access `stroke`, `push_matrix`, `pop_matrix`, `rotate` etc. in the Rocket class
