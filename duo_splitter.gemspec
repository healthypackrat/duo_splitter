
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "duo_splitter/version"

Gem::Specification.new do |spec|
  spec.name          = "duo_splitter"
  spec.version       = DuoSplitter::VERSION
  spec.authors       = ["healthypackrat"]
  spec.email         = ["healthypackrat@gmail.com"]

  spec.summary       = %q{Split "DUO 3.0 CD" into separate tracks}
  spec.homepage      = "https://github.com/healthypackrat/duo_splitter"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").select { |f| f.match(%r{^(lib|data|exe)/}) }
  end
  spec.files        += ['README.md']

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
