module Dodona::API
  class User < Spyke::Base
    attributes :username, :ugent_id, :first_name, :last_name,
               :email, :permission, :time_tone, :lang

    has_many :courses
  end
end
