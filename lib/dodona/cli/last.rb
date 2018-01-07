# frozen_string_literal: true
module Dodona::CLI
  class Last < APISubcommand
    def run()
      puts "Hello"
    end

    def self.subcommand_of(cmd)
      cmd.define_command('last') do
        name 'last'
        summary 'show last submission'
        usage 'last'
        description <<-EOS
          Show your last submission. Alias for `dodona submissions --last`.
        EOS
        runner Last
      end
    end
  end
end
