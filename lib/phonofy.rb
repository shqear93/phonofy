# frozen_string_literal: true

require_relative "phonofy/version"

require "active_record"
require "model/instance_dynamic_methods"
require "phonelib"
require "model"

module Phonofy
  class Error < StandardError; end

  class Engine < ::Rails::Engine
    initializer "phonofy.initialize" do
      ActiveSupport.on_load(:active_record) do
        include Phonofy::Model
      end

      config.i18n.load_path += Dir[config.root.join("config", "locales", "**", "*.{rb,yml}")]
    end
  end
end
