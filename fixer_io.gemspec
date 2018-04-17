
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fixer_io/version'

Gem::Specification.new do |spec|
  spec.name          = 'fixer_io'
  spec.version       = FixerIo::VERSION
  spec.authors       = ['Jan Lindblom']
  spec.email         = ['janlindblom@fastmail.fm']

  spec.summary       = 'Get exchange rates from fixer.io.'
  spec.homepage      = 'https://bitbucket.org/janlindblom/ruby-fixer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.55'
  spec.add_development_dependency 'solargraph', '~> 0.19'
  spec.add_development_dependency 'yard', '~> 0.9'
  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_development_dependency 'simplecov-rcov', '~> 0.2'
  spec.add_development_dependency 'dotenv', '~> 2.2'
  spec.add_development_dependency 'pry', '~> 0.11'
  spec.add_runtime_dependency 'rest-client', '~> 2.0'
end
