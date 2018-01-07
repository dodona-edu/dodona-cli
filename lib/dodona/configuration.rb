require 'yaml'

module Dodona
  class Configuration
    attr_reader :config
    attr_reader :file_name

    # Default values for the CLI
    DEFAULTS = {
      'host' => 'http://localhost:3000',
      'token' => '',
      'exercise_directory' => '~/dodona'
    }.freeze

    # Creates a new config object, based on a given YAML file. If no filename
    # given, '.dodonarc' in the home dir of the user will be used.
    #
    # If the file doesn't exist, an empty config will be loaded.
    #
    # @param [String] file An optional file name of the YAML file to create the
    # config from
    def initialize(file = nil)
      @file_name = file ? file : File.join(Dir.home, '.dodona.yml')
      @config = if !File.exist? file_name
                  {}
                else
                  YAML.load_file file_name
                end
      @config = DEFAULTS.merge(@config)
    end

    # Saves the config to disk. If the file doesn't exist yet, a new one will be
    # created
    def save
      File.open(file_name, 'w') { |f| f.write config.to_yaml }
    end

    # Deletes a key (reset to default)
    def delete(key)
      @config.delete(key.to_s)
    end

    # forwards [] to the internal config hash
    def [](*args)
      args.map!(&:to_s)
      @config.[](*args)
    end

    # forwards =[] to the internal config hash
    def []=(*args)
      args.map!(&:to_s)
      @config.[]=(*args)
    end
  end
end
