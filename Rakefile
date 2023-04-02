# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]

require "erb"
spec = Gem::Specification.load("phonofy.gemspec")

desc "Generate README.md from template"
task :readme do
  template = File.read("README.md.erb")
  readme = ERB.new(template).result_with_hash({ spec: spec })
  File.write("README.md", readme)
end

task default: :test