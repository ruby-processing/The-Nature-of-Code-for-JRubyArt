project 'xor' do
  model_version '4.0.0'
  id 'nn:xor:1.0-SNAPSHOT'
  packaging 'jar'

  description 'Neural Net Library for xor'

  developer 'shiffman' do
    name 'Dan Shiffman'
    roles 'developer'
  end

  properties('maven.compiler.release' => '11',
             'polyglot.dump.pom' => 'pom.xml')

  overrides do
    plugin(:compiler, '3.8.1',
           'encoding' => 'UTF-8')
  end
end
