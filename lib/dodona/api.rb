
module Dodona
  module Api
  end
end

require 'spyke'
require 'action_view/helpers'
require 'dotiw'

require_relative 'json_parser'

require_relative 'api/base'
require_relative 'api/course'
require_relative 'api/exercise'
require_relative 'api/submission'
require_relative 'api/user'

module Dodona
  module API
    def self.connect(host, token)
      Spyke::Base.connection = Faraday.new(url: host) do |c|
        c.token_auth token
        c.request :json
        c.headers['Accept'] = 'application/json'
        c.use JSONParser
        c.adapter Faraday.default_adapter
      end
    end

    def current_user
      Base.current_user
    end

    def self.motd
      Base.motd
    end
  end
end
