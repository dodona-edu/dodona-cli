require 'rubygems'
require 'bundler/setup'
require 'cri'
require 'byebug'
require_relative './config.rb'

module Dodona::CLI
  class Command
    def initialize
      @cmd = create_root_cmd
      add_status
      Config.new(@cmd)
    end

    def run(args)
      @cmd.run(args)
    end

    def add_status; end

    def add_config
    end

    def create_root_cmd
      Cri::Command.new_basic_root.modify do
        usage 'dodona command [options]'
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
