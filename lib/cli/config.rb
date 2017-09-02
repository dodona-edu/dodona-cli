module Dodona::CLI
  class Config < Subcommand
    def run
      argument_count_between! 0, 2
      key, value = *arguments
      if value
        set_config(key, value)
        puts "'#{key}' was set to '#{value}'"
      elsif key
        puts get_config(key)
      else
        config.config.each do |k, v|
          puts "#{k}: '#{v}'"
        end
      end
    end

    def set_config(key, value)
      config[key] = value
      config.save
    end

    def get_config(key)
      config[key]
    end

    def self.subcommand_of(cmd)
      cmd.define_command('config') do
        summary     'set and show configuration values'
        usage       'config [option [value]]'
        description <<-EOS
          Sets or shows configuration values. The settings are stored in $HOME/.dodona.yml by default.

          Running the command with a key and a value will set that value for the given option, running it with only a key will show the current value for that key. Running this command without arguments will show all the current configuration parameters.

          The following options are available:

            - host:   the default host for api calls

            - token:  your API token

          Example: "dodona config host http://naos.ugent.be" will set the default host to the public staging server.
        EOS

        runner Config
      end
    end
  end
end
