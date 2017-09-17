require_relative './api/base.rb'
require_relative './json_parser.rb'

module Dodona::API
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
