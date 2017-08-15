require 'cri'
require_relative './config.rb'

module Dodona::CLI
  class Command
    def initialize
      @cmd = create_root_cmd
      add_status
      add_config
    end

    def run(args)
      @cmd.run(args)
    end

    def add_status; end

    def add_config
      @cmd.define_command('config') do
        summary     'set and show configuration values'
        usage       'config option [value]'
        description <<-EOS
          Sets or shows configuration values. The settings are stored in $HOME/.dodonarc by default.

          Running the command with a value will set that value for the given option, running it without will show the current value.

          The following options are available:
            - host:   the default host for api calls
            - token:  your API token

          Example: "dodona config host http://naos.ugent.be" will set the default host to the public staging server.
        EOS

        runner Config
      end
    end

    def create_root_cmd
      Cri::Command.new_basic_root.modify do
        usage   'dodona command [options]'
        description <<-EOS
          The dodona command line interface makes your life easier by allowing
          you to submit your solutions from the command line.
        EOS

        flag :v, :version,  'display the current version'
        flag :q, :quiet,    "append '> /dev/null'"

        option nil, :config, 'specify a custom config file', argument: :required

        run do |opts, _args, cmd|
          if opts[:version]
            puts Dodona::VERSION
          else
            abort cmd.help
          end
        end
      end
    end

    def self.run(args)
      new.run(args)
    end
  end
end
