# frozen_string_literal: true

# require_relative "phonofy/fy/version"
require_relative "../validators/extended_phone_validator"

module Phonofy
  module Model
    class InstanceDynamicMethods < Module
      DEFAULT_PHONE_FORMAT = :national

      SUPPORTED_FORMATS = %i[
        international
        national
        local_number
        extension
        full_e164
        e164
        full_international
      ].freeze

      # @param [String] column_name phone number column name
      # @param [Hash] options
      def initialize(column_name, options)
        super()
        @column_name = column_name
        @options     = options
      end

      def included(base)
        column_name = @column_name

        phonelib_options            = @options[:phonelib] || {}
        phonelib_validate_enabled   = phonelib_options != false
        phonelib_validation_options = phonelib_options.delete(:validation_options) || {}

        base.class_eval do
          if phonelib_validate_enabled
            validate lambda {
              validator = Validators::ExtendedPhoneValidator.new(phonelib_options.merge(attributes: [column_name.to_s]))
              validator.validate_each(self, column_name, send("#{column_name}_before_type_cast"))
            }, **phonelib_validation_options
          end

          before_save :"#{column_name}_to_e164!", if: :"will_save_change_to_#{column_name}?"

          define_method(column_name.to_s) do |format = DEFAULT_PHONE_FORMAT|
            phone = read_attribute(column_name)
            phone = Phonelib.parse(phone)

            raise Phonelib::FormatNotSupported, format unless SUPPORTED_FORMATS.include? format

            phone.send(format)
          end

          define_method("#{column_name}_is_valid?") do
            phone = read_attribute(column_name)
            phone = Phonelib.parse(phone)
            phone.valid?
          end

          define_method("#{column_name}_object") do
            phone = read_attribute(column_name)
            Phonelib.parse(phone)
          end

          define_method("#{column_name}_to_e164!") do
            phone = read_attribute(column_name)
            write_attribute(column_name, Phonelib.parse(phone).e164)
          end
        end
      end
    end
  end
end
