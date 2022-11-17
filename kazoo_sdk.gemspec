# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kazoo_sdk/version'

Gem::Specification.new do |s|
  s.name    = 'kazoo_sdk'
  s.version = Kazoo::VERSION
  s.authors = ['Zach Bensley']
  s.email   = ['zach@bensley.id.au']

  s.homepage              = 'https://github.com/2600hz/kazoo-ruby-sdk'
  s.summary               = 'Kazoo Ruby SDK'
  s.description           = 'Used for interacting with the Kazoo HTTP API'
  s.license               = 'LGPL-3.0-or-later'
  s.required_ruby_version = '>= 2.7'

  s.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.bindir        = 'exe'
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'faraday', '~> 1'
  s.add_dependency 'faraday_middleware', '~> 1'
  s.add_dependency 'json-schema', '~> 3'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rbs'
end
