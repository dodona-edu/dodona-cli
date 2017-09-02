require_relative '../api/exercise'
require_relative './api_subcommand.rb'

module Dodona::CLI
  class Exercises < APISubcommand
    def run
      argument_count_max! 0

      exercises = Dodona::API::Exercise.all.get

      exercises.each do |e|
        puts e.name
      end
    end

    def self.subcommand_of(cmd)
      cmd.define_command('exercises') do
        name 'exercises'
        summary 'list exercises'
        usage 'exercises'
        description <<-EOS
          Lists all exercises in dodona.
        EOS

        runner Exercises
      end
    end
  end
end