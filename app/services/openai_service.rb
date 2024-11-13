require "net/http"
require "uri"
require "json"

class OpenaiService
  private

  def requests(custom_text = "")
    uri = URI("https://api.openai.com/v1/chat/completions")
    request = Net::HTTP::Post.new(uri)

    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer #{Rails.credentials.openai.api_key}"

    request.body = {
      model: "gpt-4-turbo",
      messages: [ { role: "user", content: custom_text } ],
      stream: false
    }.to_json
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
    puts JSON.parse(response.body)
    JSON.parse(response.body)["choices"][0]["message"]["content"]
  end
end
