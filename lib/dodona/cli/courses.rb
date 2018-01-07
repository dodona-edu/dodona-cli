module Dodona::CLI
  class Courses < APISubcommand
    def run
      argument_count_max! 0
      courses =
        if options[:all]
          Course.all.get
        else
          current_user.courses.get
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
        description <<-EOS
          Lists your current courses, or all available courses if the `--all` flag is given.
        EOS

        flag :a, :all, 'lists all courses'

        runner Courses
      end
    end
  end
end
