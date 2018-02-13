# frozen_string_literal: true

module Dodona::CLI
  class APISubcommand < Subcommand
    include Dodona::API

    def initialize(*args)
      super(*args)
      Dodona::API.connect(config[:host], config[:token])
    end

    def base
      @base ||= Base.all.get
    end

    def current_user
      base.user
    end

    def deadlines
      base.deadline_series
    end

    def check_client_supported!
      min_version = Base.min_supported_client
      min_version_numbers = min_version.split('.').map(&:to_i)
      this_version = [Dodona::Version::MAJOR,
                      Dodona::Version::MINOR,
                      Dodona::Version::PATCH]

      this_version.zip(min_version_numbers) do |client, server|
        break if client > server
        out_of_date(version) if client < server
      end
    end

    private

    def out_of_date!(min_version)
      msgs = [
        'Your client is out of date!',
        "Minimum version: #{min_version}",
        "Your version: #{Dodona::VERSION}",
        '',
        'Update your client with `gem install dodona-cli`'
      ].join "\n"
      puts Pastel.new.red(msgs)
      abort
    end
  end
end
