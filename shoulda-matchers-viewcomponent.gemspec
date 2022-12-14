# frozen_string_literal: true

require_relative "lib/shoulda/matchers/view_component/version"

Gem::Specification.new do |spec|
  spec.name = "shoulda-matchers-viewcomponent"
  spec.version = Shoulda::Matchers::ViewComponent::VERSION
  spec.authors = ["Pedro Carbajal"]
  spec.email = ["pedro_c@beezwax.net"]

  spec.summary = "Shoulda matchers extension for ViewComponent"
  spec.homepage = "https://github.com/beezwax/shoulda-matchers-viewcomponent"
  spec.required_ruby_version = ">= 2.6.0"

  spec.license = "MIT"

  #spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/beezwax/shoulda-matchers-viewcomponent/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "shoulda-matchers", "~> 4.0"

  spec.add_development_dependency "view_component"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rails"
end
