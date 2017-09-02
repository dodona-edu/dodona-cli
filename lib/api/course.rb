require 'spyke'

module Dodona::API
  class Course < Spyke::Base
    attributes :name, :year
  end
end
