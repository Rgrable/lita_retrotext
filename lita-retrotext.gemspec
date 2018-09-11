Gem::Specification.new do |spec|
  spec.name          = "lita-retrotext"
  spec.version       = "0.0.3"
  spec.authors       = ["Richard Grable"]
  spec.email         = ["richard.grable@gmail.com"]
  spec.description   = "Generates a retro text image"
  spec.summary       = "Be super hip with retro text images"
  spec.homepage      = "https://github.com/rgrable/lita_retrotext"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.6"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0.0"
  spec.add_development_dependency "nokogiri"
end