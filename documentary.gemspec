basedir = File.expand_path(File.dirname(__FILE__))
require "#{basedir}/lib/documentary/version"

Gem::Specification.new do |s|
  s.name          = 'documentary'
  s.version       = Documentary::VERSION
  s.summary       = 'Documentary'
  s.description   = 'Simple, useable, runnable API documentation'
  s.authors       = ['Dave Kennedy']
  s.email         = 'david@bangline.co.uk'
  s.files         = `git ls-files`.split("\n")
  s.require_path  = 'lib'
  s.executables   = ['documentary']
  s.homepage      = 'http://rubygems.org/gems/documentary'
  s.license       = 'MIT'

  s.add_dependency 'activesupport'
  s.add_development_dependency 'minitest', '~> 5.4.3'
  s.add_development_dependency 'rake', '~> 10.3.2'
end
