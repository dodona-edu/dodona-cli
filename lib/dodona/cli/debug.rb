# frozen_string_literal: true

module Dodona::CLI
  class Debug < APISubcommand
    def run
      puts 'Starting debugging session'

      # rubocop:disable Lint/Debugger
      byebug
    end

    def self.subcommand_of(cmd)
      cmd.define_command('debug') do
        name 'debug'
        summary 'start an intereactive debugging session'
        usage 'status'
        description <<-HERE
          Starts an interactive debugging session using byebug
        HERE

        runner Debug
      end
    end
  end
end
