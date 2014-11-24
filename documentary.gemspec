Gem::Specification.new do |s|
  s.name          = 'documentary'
  s.version       = '0.0.1'
  s.summary       = 'Documentary'
  s.description   = 'Simple, useable, runnable API documentation'
  s.authors       = ['Dave Kennedy']
  s.email         = 'david@bangline.co.uk'
  s.files         = `git ls-files`.split("\n")
  s.require_path  = 'lib'
  s.homepage      = 'http://rubygems.org/gems/documentary'
  s.license       = 'MIT'

  s.add_development_dependency 'minitest', '~> 5.4.3'
  s.add_development_dependency 'rake', '~> 10.3.2'
  s.add_development_dependency 'pry'
end
