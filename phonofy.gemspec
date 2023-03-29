# frozen_string_literal: true

require_relative "lib/phonofy/version"

Gem::Specification.new do |spec|
  spec.name    = "phonofy"
  spec.version = Phonofy::VERSION
  spec.authors = ["Khaled AbuShqear"]
  spec.email   = ["qmax93@gmail.com"]

  spec.summary               = "TODO: Write a short summary, because RubyGems requires one."
  spec.description           = "TODO: Write a longer description or delete this line."
  spec.homepage              = "TODO: Put your gem's website or public repo URL here."
  spec.license               = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://github.com/"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/shqear93/phonofy"
  spec.metadata["changelog_uri"]   = "https://github.com/shqear93/phonofy/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Dependencies
  spec.add_dependency "phonelib"
  spec.add_dependency "activerecord"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
