require_relative './user.rb'

module Dodona::API
  class Base < Spyke::Base
    uri '/'

    has_one :user

    attributes :motd

    def self.current_user
      all.get.user
    end

    def self.motd
      all.get.motd
    end
  end
end