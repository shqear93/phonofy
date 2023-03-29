# frozen_string_literal: true

require_relative "lib/phonofy/version"

Gem::Specification.new do |spec|
  spec.name    = "phonofy"
  spec.version = Phonofy::VERSION
  spec.authors = ["Khaled AbuShqear"]
  spec.email   = ["qmax93@gmail.com"]

  spec.summary               = "Phonofy integrates with rails ActiveRecord to provide formatting functionalities."
  spec.description           = "Phonofy is a Ruby gem that simplifies phone number formatting in Rails applications using the Phonelib library. With Phonofy, you can easily parse and format phone number data according to international standards, ensuring that your phone number data is consistent and valid across your application."
  spec.homepage              = "https://github.com/shqear93/phonofy"
  spec.license               = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

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
