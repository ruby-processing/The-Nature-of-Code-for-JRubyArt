# The-Nature-of-Code-Examples-in-JRubyArt #

A new ruby port of the [examples][] from [The Nature of Code][] by Daniel Shiffman. Samples have been adapted to run with JRubyArt (processing-3.4+ and ruby-2.2+), from the [original ruby port][]. Some of the changes in this version are required because of changes to processing (eg. size now belongs in settings), but others have been made to take advantage of newer ruby syntax. In particular the fact keyword arguments are now first class citizens, so argument order should no longer be an issue, and method signatures can have more meaning.


Although many of the sketches here stand on their own merit, you should remember that they were originally designed to illustrate the book (so to get the most from them you should definetly [get the book][]). Since the sketches have been translated to a more idiomatic ruby, some of the sketches may not exactly match the points made in the book. However such sketches do serve to demonstrate the differences between processing and JRubyArt. Since the book is now also available in [Japanese][] it would be great if someone would fork this and add Japanese annotations. For the most part the code is just ruby and processing, but see [glossary][] for some convenience methods unique to JRubyArt (eg `load_library`, `map1d`, `constrained_map`).

## Tested versions

ruby 2.3

jruby-9.2.4.0

JRubyArt gem version 1.6.1 (processing-3.4)

pbox2d gem version 1.0.3


[The Nature of Code]:http://natureofcode.com
[get the book]:http://natureofcode.com
[Japanese]:http://www.amazon.co.jp/Nature-Code--Processing%E3%81%A7%E3%81%AF%E3%81%98%E3%82%81%E3%82%8B%E8%87%AA%E7%84%B6%E7%8F%BE%E8%B1%A1%E3%81%AE%E3%82%B7%E3%83%9F%E3%83%A5%E3%83%AC%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3--%E3%83%80%E3%83%8B%E3%82%A8%E3%83%AB%E3%83%BB%E3%82%B7%E3%83%95%E3%83%9E%E3%83%B3/dp/4862462456/
[examples]:https://github.com/shiffman/The-Nature-of-Code-Examples
[original ruby port]:https://github.com/ruby-processing/The-Nature-of-Code-Examples-in-Ruby
[glossary]:https://github.com/ruby-processing/The-Nature-of-Code-for-JRubyArt/wiki/glossary
