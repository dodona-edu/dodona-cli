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
      @pwd = Pathname.new Dir.pwd
      @pastel = Pastel.new
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
      raise 'Already configured' if configured?
      @options = DEFAULTS.merge(options)
      @config = Dodona::Configuration.new @options[:config]
      @dodona_dir = Pathname.new(@config[:exercise_directory]).expand_path.realdirpath
      @dirs_until_dodona_dir = dirs_until_dodona_dir
      @connected = false
    end

    def config
      raise 'Not yet configured' unless configured?
      @config
    end

    def connect
      raise 'Already connected' if @connected
      host = config[:host]
      token = config[:token]
      puts @pastel.yellow('No authentication token set up.') if token.blank?
      Spyke::Base.connection = Faraday.new(url: host) do |c|
        c.token_auth token
        c.request :json
        c.headers['Accept'] = 'application/json'
        c.use JSONParser
        c.adapter Faraday.default_adapter
      end
      @connected = true
    end

    def in_dodona_dir?
      @dirs_until_dodona_dir.any?
    end

    def current_course
      return nil unless in_dodona_dir?
      @dirs_until_dodona_dir.first
    end

    def current_series
      return nil unless @dirs_until_dodona_dir.size >= 2
      @dirs_until_dodona_dir[1]
    end

    def current_exercise
      return nil unless @dirs_until_dodona_dir.size >= 3
      @dirs_until_dodona_dir[2]
    end

    private

    # Returns a list of all the directories from the current directory
    # until the exercise directory (inclusive).
    # The list is empty if not in the exercise directory.
    def dirs_until_dodona_dir
      dir = @pwd
      children = [dir]
      loop do
        return [] if dir.root?
        return children if dir == @dodona_dir
        children.unshift dir
        dir = dir.parent
      end
    end
  end
end
