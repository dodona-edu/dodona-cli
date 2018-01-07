require 'json'
require 'pastel'

class JSONParser < Faraday::Response::Middleware
  def parse(body)
    json = JSON.parse(body)
    {
      data: json
    }
  rescue JSON::ParserError
    if body.nil? || body.empty?
      puts Pastel.new.red('Received an empty response from the server. Is your token correct?')
      abort
    end
  end
end
