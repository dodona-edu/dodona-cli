# frozen_string_literal: true

module Dodona::API
  class Series < Spyke::Base
    attributes :name, :deadline, :description, :order

    has_one :course
    has_many :exercises

    include Pathable

    def path
      course
    end

    def to_s
      name
    end
  end
end
