require_relative '../api/submission'
require_relative './api_subcommand.rb'

require 'action_view/helpers'
require 'dotiw'

module Dodona::CLI
  class Submissions < APISubcommand
    include ActionView::Helpers::DateHelper

    def run
      argument_count_max! 0

      submissions = Submission.all.get

      if options[:last]
        last = submissions.last
        submissions = [last]
      end

      submissions.each do |s|
        puts "#{time_ago_in_words(s.created_at)} -> (#{s.status}) #{s.summary}"
      end
    end

    def self.subcommand_of(cmd)
      cmd.define_command('submissions') do
        name 'submissions'
        summary 'list submissions'
        usage 'submissions'
        description <<-EOS
          Lists all your submissions in dodona.
        EOS

        flag :l, :last, 'List only your last submission.'

        runner Submissions
      end
    end
  end
end
