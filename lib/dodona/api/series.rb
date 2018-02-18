# frozen_string_literal: true

module Dodona::API
  class Series < Spyke::Base
    attributes :name, :deadline, :description, :order

    has_many :exercises
  end
end
