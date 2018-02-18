# frozen_string_literal: true

module Dodona::CLI
  class Courses < APISubcommand
    def run
      argument_count_max! 0
      courses =
        if options[:all]
          Course.all.get
        else
          current_user.courses
        end
      courses.each do |c|
        puts c.name
      end
    end

    def self.subcommand_of(cmd)
      cmd.define_command('courses') do
        name    'courses'
        summary 'list courses'
        usage   'courses [subcommand]'
        description <<-DESC
          Lists your current courses, or all available courses if the `--all` flag is given.
        DESC

        flag :a, :all, 'lists all courses'

        runner Courses
      end
    end
  end
end
