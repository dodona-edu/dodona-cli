# frozen_string_literal: true
module Dodona::API
  class User < Spyke::Base
    attributes :username, :ugent_id, :first_name, :last_name,
               :email, :permission, :time_zone, :lang,
               :submission_count, :correct_exercises

    has_many :subscribed_courses, class_name: 'Dodona::API::Course', uri: nil
    has_many :submissions

    def courses
      subscribed_courses
    end
  end
end
