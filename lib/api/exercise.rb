module Dodona::API
  class Exercise < Spyke::Base
    attributes :name, :boilerplate, :description_format, :file_name,
               :has_correct_solution, :last_solution_correct

    def to_s
      "#{id}: #{name}"
    end
  end
end
