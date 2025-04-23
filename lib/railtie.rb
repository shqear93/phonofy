# frozen_string_literal: true

require "rails"
require "pathname"
require_relative "model"

module Phonofy
  class Railtie < Rails::Railtie
    initializer "phonofy.initialize" do
      ActiveSupport.on_load(:active_record) do
        include Phonofy::Model
      end
    end

    initializer "phonofy.load_translations" do
      # Use Rails.root if available, otherwise use the gem's path
      if defined?(Rails.root) && Rails.root
        config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]
      else
        # Fallback to the gem's own translations
        gem_root = Pathname.new(File.expand_path("../", __dir__))
        config.i18n.load_path += Dir[gem_root.join("config", "locales", "**", "*.{rb,yml}")]
      end
    end
  end
end
