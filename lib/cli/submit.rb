require_relative './api_subcommand'

module Dodona::CLI
  class Submit < APISubcommand
    def run
      code =
        if arguments.count.zero? && options[:code]
          options[:code]
        elsif arguments.count == 1 && options[:code].nil?
          File.read(arguments.first).strip
        else
          abort @cmd.help
        end

      submission = Submission.create code: code.strip,
                                     exercise_id: options[:exercise],
                                     course_id: options[:course]
      p submission.reload
    rescue Errno::ENOENT
      abort 'File does not exist or is not readable.'
    end

    def self.subcommand_of(cmd)
      cmd.define_command('submit') do
        name 'submit'
        usage 'submit [FILE]'
        summary 'create a new submission'
        description <<-EOS
          Submit a solution to dodona. You must either give a FILE as argument, or the code itself with the --code option.
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
