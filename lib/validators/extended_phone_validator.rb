# frozen_string_literal: true

require_relative "../validators"
require "#{Gem::Specification.find_by_name("phonelib").gem_dir}/lib/validators/phone_validator"
require "active_model/version"

module Phonofy
  module Validators
    class ExtendedPhoneValidator < PhoneValidator
      def validate_each(record, attribute, value)
        return if options[:allow_blank] && value.blank?

        @phone = parse(value, specified_country(record))
        valid  = countries.present? ? valid_country? : phone_valid?
        valid  = valid && valid_types? && valid_extensions?

        unless valid
          # Rails 8.0+ compatibility - errors.add no longer accepts options as a third argument
          if ActiveModel.version >= Gem::Version.new('8.0.0')
            # For Rails 8.0+, use the new API
            record.errors.add(attribute, message(error_message), **options)
          else
            # For older Rails versions, use the old API
            record.errors.add(attribute, message(error_message), options)
          end
        end
      end

      private

      def message(custom = :invalid)
        options[:message] || custom
      end

      def error_message
        return :invalid_country if countries.present? && !valid_country?
        return :invalid if !countries.present? && !phone_valid?
        return :invalid_type unless valid_types?
        return :invalid_extension unless valid_extensions?

        :invalid
      end

      def valid_country?
        return true unless options[:countries]

        countries.any? { |country| @phone.valid_for_country?(country) }
      end
    end
  end
end
