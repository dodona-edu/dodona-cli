# frozen_string_literal: true

module Dodona::CLI
  class Status < APISubcommand
    def run
      argument_count_max! 0
      check_client_supported!

      puts "Dodona #{application_version}"
      puts "You are #{current_user.first_name} #{current_user.last_name}"
      puts deadline_string
      puts "Submissions: #{current_user.submission_count}"
      puts "Solved exercises: #{current_user.correct_exercises}"
      puts "Current course: #{state.current_course}"
      puts "Current series: #{state.current_series}"
      puts "Current exercise: #{state.current_exercise}"
    end

    def deadline_string
      c = deadlines.count
      num = c.zero? ? 'No' : c
      pluralized = c == 1 ? 'deadline' : 'deadlines'
      "#{num} upcoming #{pluralized}"
    end

    def self.subcommand_of(cmd)
      cmd.define_command('status') do
        name 'status'
        summary 'show the current status'
        usage 'status'
        description <<-HERE
          Shows the message of the day and as who you are logged in.
        HERE

        runner Status
      end
    end
  end
end
