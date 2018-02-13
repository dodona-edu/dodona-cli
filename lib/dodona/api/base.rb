# frozen_string_literal: true

module Dodona::API
  class Base < Spyke::Base
    uri '/'

    has_one :user

    has_many :dealine_series, class_name: 'Series'

    attributes :version, :min_supported_client

    def self.current_user
      all.get.user
    end

    def self.deadlines
      all.get.deadline_series
    end

    def self.version
      all.get.version
    end

    def self.min_supported_client
      all.get.min_supported_client
    end
  end
end
