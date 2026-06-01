# frozen_string_literal: true

require_relative "model/class_methods"

module Phonofy
  module Model
    def self.included(base)
      base.extend ClassMethods
    end
  end
end