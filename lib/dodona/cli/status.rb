# frozen_string_literal: true
module Dodona::CLI
  class Status < APISubcommand
    def run
      argument_count_max! 0

      puts "Message of the day: #{motd}\n"
      puts "You are #{current_user.first_name} #{current_user.last_name}"
    end

    def self.subcommand_of(cmd)
      cmd.define_command('status') do
        name 'status'
        summary 'show the current status'
        usage 'status'
        description <<-EOS
          Shows the message of the day and as who you are logged in.
        EOS

        runner Status
      end
    end
  end
end
