# frozen_string_literal: true

require_relative "../validators"
require "#{Gem::Specification.find_by_name("phonelib").gem_dir}/lib/validators/phone_validator"

module Phonofy
  module Validators
    class ExtendedPhoneValidator < PhoneValidator
      def validate_each(record, attribute, value)
        return if options[:allow_blank] && value.blank?

        @phone = parse(value, specified_country(record))
        valid  = countries.present? ? valid_country? : phone_valid?
        valid  = valid && valid_types? && valid_extensions?

        record.errors.add(attribute, message(error_message), options) unless valid
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
