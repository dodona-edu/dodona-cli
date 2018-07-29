# frozen_string_literal: true

module Dodona::CLI
  class Next < APISubcommand
    def run
      argument_count_max! 0

      course = select_course
      byebug
      series = select_series(course)
      exercise = select_exercise(series)

      exercise.cd!
    end

    def select_course
      state.current_course || \
        prompt.select('Which course?', current_user.courses)
    end

    def select_series(course)
      state.current_series || \
        prompt.select('Which series?', course.series)
    end

    def select_exercise(series)
      if state.current_exercise
        select_next_exercise
      else
        prompt.select('Which exercise?', series.exercises)
      end
    end

    def select_next_exercise(series, exercise)
      exercises = series.exercises
      idx = exercises.find_index(exercise)
      raise 'Exercise not from this series' if idx.nil?
      exercices[idx + 1]
    end

    def prompt
      @prompt ||= TTY::Prompt.new
    end

    def self.subcommand_of(cmd)
      cmd.define_command('next') do
        name 'next'
        summary 'go to your next exercise'
        usage 'next'
        description <<-HERE
          Changes your current directory to the next exercise you can solve.
        HERE

        runner Next
      end
    end
  end
end
