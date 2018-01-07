# frozen_string_literal: true

module Dodona
  # Singleton class that knowns the current state of the application.
  # It needs to be configured before certain methods can be used.
  class State
    include Singleton

    attr_reader :pwd

    # Default values of our State
    DEFAULTS = {
      verbose: false
    }.freeze

    def initialize
      @pwd = Dir.pwd
    end

    def verbose?
      options[:verbose]
    end

    def configured?
      !@options.nil?
    end

    def options
      raise 'Not yet configured' unless configured?
      @options
    end

    def configure(options)
      raise 'Already configured!' if configured?
      @options = DEFAULTS.merge(options)
      @config = Dodona::Configuration.new @options[:config]
    end

    def config
      raise 'Not yet configured' unless configured?
      @config
    end

    def current_course
      if @pwd.starts_with? config[:exercise_directory]
      end
    end

    def current_exercise
    end
  end
end
