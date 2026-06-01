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

  self.configuration = Configuration.new
end

# Load ActiveRecord-related code conditionally
if defined?(ActiveRecord)
  require_relative "phonofy/model/instance_dynamic_methods"
  require_relative "phonofy/model"
end

# Only load the Railtie if Rails is available
require_relative "phonofy/railtie" if defined?(Rails)
