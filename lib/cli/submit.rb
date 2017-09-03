require_relative './api_subcommand'
require_relative '../core/submitter'

module Dodona::CLI
  class Submit < APISubcommand
    include Dodona::Core

    def fetch_code
      code =
        if arguments.count.zero? && options[:code]
          options[:code]
        elsif arguments.count == 1 && options[:code].nil?
          File.read(arguments.first)
        else
          abort @cmd.help
        end
      code.strip
    rescue Errno::ENOENT
      abort 'File does not exist or is not readable.'
    end

    def run
      Dodona::Core::Submitter.new.submit_with_progress fetch_code,
                                                       exercise: options[:exercise],
                                                       course: options[:course]
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
