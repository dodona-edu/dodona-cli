# frozen_string_literal: true
module Dodona::API
  class Course < Spyke::Base
    attributes :name, :year

    def self.for_user(user)
      user.courses
    end

    def to_s
      "#{id}: #{name} [#{year}]"
    end
  end
end
