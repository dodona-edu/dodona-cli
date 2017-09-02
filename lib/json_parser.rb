require 'json'

class JSONParser < Faraday::Response::Middleware
  def parse(body)
    json = JSON.parse(body)
    {
      data: json
    }
  end
end
