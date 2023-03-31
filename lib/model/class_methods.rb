# frozen_string_literal: true
# require_relative "phonofy/fy/version"

module Phonofy
  module Model
    module ClassMethods

      DEFAULTS = { phonelib: { allow_blank: true, validation_options: {} } }.freeze

      def phonofy(column_name = :phone_number, **options)
        options = DEFAULTS.deep_merge(options)

        unless respond_to? :phonofy_configs
          class_attribute :phonofy_configs
          self.phonofy_configs = { _counter: {} }
        end

        counter                                 = (phonofy_configs[:_counter][column_name] ||= 0)
        phonofy_configs[:_counter][column_name] += 1

        phonofy_configs["#{column_name}_#{counter}"] = options.dup

        include InstanceDynamicMethods.new(column_name, options)
      end
    end
  end
end
