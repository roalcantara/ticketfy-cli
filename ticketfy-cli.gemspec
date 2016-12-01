# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ticketfy/cli/version'

Gem::Specification.new do |spec|
  spec.name          = 'ticketfy-cli'
  spec.version       = Ticketfy::Cli::VERSION
  spec.authors       = ['Rogério Rodrigues de Alcântara']
  spec.email         = ['rogerio.alcantara@gmail.com']

  spec.summary       = "Ticketfy's REST API command line interface"
  spec.description   = 'Ticketfy CLI is a handy interface to its REST API'
  spec.homepage      = 'https://github.com/roalcantara/ticketfy-cli'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler',    '~> 1.12'
  spec.add_development_dependency 'rake',       '~> 10.0'
  spec.add_development_dependency 'rspec',      '~> 3.0'
  spec.add_development_dependency 'byebug',     '~> 9.0', '>= 9.0.6'
end
