require_relative '../api'

module Dodona::CLI
  class APISubcommand < Subcommand
    def initialize(*args)
      super(*args)
      Dodona::API.connect(config[:host], config[:token])
    end

    def base
      @base ||= Dodona::API::Base.all.get
    end

    def current_user
      base.user
    end

    def motd
      base.motd
    end
  end
end
