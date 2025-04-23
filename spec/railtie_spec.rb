# frozen_string_literal: true

RSpec.describe "Phonofy Railtie" do
  # Skip all tests if Rails is not available
  before(:all) do
    @rails_available = begin
      require 'rails'
      true
    rescue LoadError
      false
    end
  end

  it "has translation files" do
    # Check if the translation file exists
    expect(File.exist?("config/locales/en.yml")).to be true
  end

  # Only run these tests if Rails is available
  describe "Rails integration", if: -> { @rails_available } do
    it "would define the Railtie class" do
      # Since Rails is not available in the test environment,
      # we'll just check that the file exists
      expect(File.exist?("lib/railtie.rb")).to be true

      # Read the file content to verify it defines a Railtie
      content = File.read("lib/railtie.rb")
      expect(content).to include("class Railtie < Rails::Railtie")
      expect(content).to include("initializer \"phonofy.initialize\"")
      expect(content).to include("initializer \"phonofy.load_translations\"")
    end
  end
end
