# frozen_string_literal: true
module Dodona
  class JSONParser < Faraday::Response::Middleware

    def on_complete(env)
      if env[:status] == 401
        unauthorized!
      end

      env.body = parse(env.body)
    end

    def unauthorized!
      msg = [ "The server responded with unauthorized status.",
              "Your API Token is probably incorrect." ]

      pastel = Pastel.new
      msg.each { |m| puts pastel.red(m) }

      abort
    end


    def parse(body)
      json = JSON.parse(body)
      {
        data: json
      }
    end
  end
end
