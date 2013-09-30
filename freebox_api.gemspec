require File.expand_path('../lib/freebox_api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mickaël Canévet"]
  gem.email         = 'mickael.canevet@gmail.com'
  gem.description   = %q{Helps you to use Freebox OS's API calls from your app}
  gem.summary       = %q{Ruby bindings for Freebox OS's rest API}
  gem.homepage      = 'http://github.com/mcanevet/freebox_api'

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'freebox_api'
  gem.require_paths = ["lib"]
  gem.version       = FreeboxApi::VERSION
  gem.license       = 'Apache 2.0'

  gem.add_dependency 'json'
  gem.add_dependency 'rest-client', '>= 1.6.1'
end
