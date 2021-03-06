# frozen_string_literal: true

module Dodona::API
  class Exercise < Spyke::Base
    attributes :name, :boilerplate, :description_format, :file_name,
               :has_correct_solution, :last_solution_correct

    has_one :series

    include Pathable

    def path
      series.path + '/' + sanitize_filename(name)
    end

    def to_s
      "#{id}: #{name}"
    end
  end
end
