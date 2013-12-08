# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'linked-list/version'

Gem::Specification.new do |spec|
  spec.name          = 'linked-list'
  spec.version       = Linked::List::VERSION
  spec.authors       = ['Yury Velikanau']
  spec.email         = ['yury.velikanau@gmail.com']
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = 'https://github.com/spectator/linked-list'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'bundler',  '>= 1.3', '<= 2.0'
  spec.add_development_dependency 'minitest', '>= 5.0', '<= 6.0'
end