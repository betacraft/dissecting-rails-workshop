require_relative "lib/railties_demo/version"

Gem::Specification.new do |spec|
  spec.name        = "railties_demo"
  spec.version     = RailtiesDemo::VERSION
  spec.authors     = %w[harunkumars ratnadeep]
  spec.email       = %w[harun@betacraft.io rtdp@betacraft.io]
  spec.homepage    = "https://github.com/betacraft/dissecting-rails-workshop"
  spec.summary     = "Summary of RailtiesDemo."
  spec.description = "Description of RailtiesDemo."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/betacraft/dissecting-rails-workshop"
  spec.metadata["changelog_uri"] = "https://github.com/betacraft/dissecting-rails-workshop"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.4.3"
  spec.add_development_dependency 'puma', '~> 6.2'
  spec.add_development_dependency "byebug", "~> 11.1"
end
