# frozen_string_literal: true

require_relative "phonofy/version"
require "phonelib"

module Phonofy
  class Error < StandardError; end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.config
    configuration
  end

  class Configuration
    attr_accessor :default_phonelib_options

    def initialize
      @default_phonelib_options = {}
    end
  end

  # Initialize default configuration
  self.configuration = Configuration.new
end

# Load ActiveRecord-related code
require "active_record"
require_relative "model/instance_dynamic_methods"
require_relative "model"

# Only load the Railtie if Rails is available
if defined?(Rails)
  require_relative "railtie"
end

# Model is already required above
