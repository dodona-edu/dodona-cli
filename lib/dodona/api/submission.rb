module Dodona::API
  class Submission < Spyke::Base
    include ActionView::Helpers::DateHelper
    attributes :summary, :accepted, :code, :result, :created_at

    belongs_to :exercise
    belongs_to :course
    belongs_to :user

    include_root_in_json :submission

    def self.submit(params, wait_seconds = 1)
      submission = create(params)
      submission.reload
      while %(queued running).include? submission.status
        yield submission
        sleep(wait_seconds)
        submission.reload
      end
      yield submission
      submission
    end

    def to_s
      "#{time_ago_in_words(created_at)} -> (#{status}) #{summary}"
    end
  end
end
