# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/oschina/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-oschina"
  spec.version       = Omniauth::Oschina::VERSION
  spec.authors       = ["WangZhenwei"]
  spec.email         = ["jack230230@gmail.com"]
  spec.description   = %q{oauth2 for www.oschina.net}
  spec.summary       = %q{oauth2 for www.oschina.net}
  spec.homepage      = "http://www.oschina.net"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
