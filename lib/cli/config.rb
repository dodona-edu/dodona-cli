require_relative '../configuration.rb'

module Dodona::CLI
  class Config
    def initialize(cmd)
      cmd.define_command('config') do
        summary     'set and show configuration values'
        usage       'config option [value]'
        description <<-EOS
          Sets or shows configuration values. The settings are stored in $HOME/.dodona.yml by default.

          Running the command with a value will set that value for the given option, running it without will show the current value.

          The following options are available:
            - host:   the default host for api calls
            - token:  your API token

          Example: "dodona config host http://naos.ugent.be" will set the default host to the public staging server.
        EOS

        run do |arguments, options|
          abort command.help unless arguments.count.between?(1, 2)

          @config = Dodona::Configuration.new options[:config]
          set_or_show(arguments)
        end
      end
    end

    def show_or_set(arguments)
      key, value = *arguments
      if value
        set_config(key, value)
        puts "'#{key}' was set to '#{value}'"
      else
        puts get_config(key)
      end
    end

    def set_config(key, value)
      @config[key] = value
      @config.save
    end

    def get_config(key)
      @config[key]
    end
  end
end
