# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'linked-list/version'

Gem::Specification.new do |spec|
  spec.name          = 'linked-list'
  spec.version       = Linked::List::VERSION
  spec.authors       = ['Yury Velikanau']
  spec.email         = ['yury.velikanau@gmail.com']
  spec.description   = %q(Ruby implementation of Doubly Linked List, following some Ruby idioms.)
  spec.summary       = %q(Ruby implementation of Doubly Linked List, following some Ruby idioms.)
  spec.homepage      = 'https://github.com/spectator/linked-list'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 2.0', '< 3.0'
  spec.add_development_dependency 'coveralls', '~> 0'
  spec.add_development_dependency 'm', '~> 1.5', '>= 1.5.0'
  spec.add_development_dependency 'minitest', '>= 5.0', '<= 6.0'
  spec.add_development_dependency 'rake', '>= 12.3.3'
end
