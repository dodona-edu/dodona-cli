module Dodona::API
  class Submission < Spyke::Base
    attributes :summary, :accepted, :code, :result

    belongs_to :exercise
    belongs_to :course
    belongs_to :user

    include_root_in_json :submission
  end
end
