# frozen_string_literal: true
module Dodona::CLI
  class List < APISubcommand
    TYPES = {
      courses: Course,
      exercises: Exercise,
      submissions: Submission
    }.freeze

    def run
      argument_count_exact! 1
      @type = arguments.first.to_sym
      @model = TYPES[@type]
      abort "Unrecognised type: #{type}" unless @model
      puts query.get.join("\n")
    end

    def query
      if options[:all]
        @model.all
      else
        @model.for_user(current_user)
      end
    end

    def self.subcommand_of(cmd)
      cmd.define_command('list') do
        name 'list'
        summary 'lists courses, series, exercises or submissions'
        usage 'list [type]'
        description <<-EOS
          Lists items of the given type. The supported types are: courses, series, exercises and submissions.

          Shows the items which are relevant for you in the current context by default.
          For example: when you `list courses` is used,
          it lists the courses where you are a member of.

          The --all flag overrides this. Not all types implement this.

          Aditional parameters may be given to specify which items have to be shown.
        EOS

        flag :a, :all, 'list all items, not only those relevant to you'

        optional :e, :exercise, 'list items belonging to the given exercise',
                 argument: :required

        optional :s, :series, 'list items belonging to the given series',
                 argument: :required

        optional :c, :course, 'list items belonging to the given course',
                 argument: :required

        runner List
      end
    end
  end
end
