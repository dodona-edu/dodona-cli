require_relative './api_subcommand'
require_relative './submissions'

module Dodona::CLI
  class Last < APISubcommand
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
