# frozen_string_literal: true
module Dodona::API
  class User < Spyke::Base
    attributes :username, :ugent_id, :first_name, :last_name,
               :email, :permission, :time_tone, :lang

    has_many :courses
    has_many :submissions
  end
end
