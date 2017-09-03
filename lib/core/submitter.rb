require 'tty/spinner'

require_relative '../api/submission'

module Dodona::Core
  class Submitter
    include Dodona::API

    def submit_with_progress(code, **options)
      exercise = options[:exercise]
      course = options[:course]
      submission = Submission.create code: code,
                                     exercise_id: exercise,
                                     course_id: course
      result = wait_for_result submission
    end

    private

    def wait_for_result(submission, sleeptime: 1)
      spinner = TTY::Spinner.new('[:spinner] :status', hide_cursor: true)
      spinner.update(status: 'waiting for response')
      submission.reload
      spinner.auto_spin
      while %w[queued running].include? submission.status
        spinner.update(status: submission.status)
        sleep(sleeptime)
        submission.reload
      end
      spinner.update(status: submission.status)
      if submission.accepted
        spinner.success "(#{submission.summary})"
      else
        spinner.error "(#{submission.summary})"
      end
      submission.result
    end
  end
end
