require_relative './api_subcommand'

require 'tty/spinner'

module Dodona::CLI
  class Submit < APISubcommand
    def fetch_code
      code =
        if arguments.count.zero? && options[:code]
          options[:code]
        elsif arguments.count == 1 && options[:code].nil?
          File.read(arguments.first)
        else
          abort @command.help
        end
      code.strip
    rescue Errno::ENOENT
      abort 'File does not exist or is not readable.'
    end

    def run
      params = {
        code: fetch_code,
        exercise_id: options[:exercise],
        course_id: options[:course]
      }

      spinner = TTY::Spinner.new('[:spinner] :status', hide_cursor: true)
      spinner.update(status: 'sending submission')
      spinner.auto_spin

      submission = Submission.submit(params) do |sub|
        spinner.update(status: sub.status)
      end

      if submission.accepted
        spinner.success "(#{submission.summary})"
      else
        spinner.error "(#{submission.summary})"
      end
      puts submission
    end

    def self.subcommand_of(cmd)
      cmd.define_command('submit') do
        name 'submit'
        usage 'submit [FILE]'
        summary 'create a new submission'
        description <<-EOS
          Submit a solution to dodona. You must either give a FILE as argument or the code itself with the --code option.
        EOS

        required :e, :exercise,
                 'ID of the exercise to which this submission must be made'

        optional nil, :code,
                 'code to submit instead of giving a FILE', argument: :required

        optional :c, :course,
                 'course ID which should be associated to this submission'

        runner Submit
      end
    end
  end
end
