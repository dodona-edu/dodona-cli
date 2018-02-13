# frozen_string_literal: true
module Dodona::API
  class User < Spyke::Base
    attributes :username, :ugent_id, :first_name, :last_name,
               :email, :permission, :time_zone, :lang,
               :submission_count, :correct_exercises

    has_many :courses
    has_many :submissions
  end
end
