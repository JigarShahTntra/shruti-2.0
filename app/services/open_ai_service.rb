require "net/http"
require "uri"
require "json"

class OpenAiService
  def initialize(conversation = [], format_options = {})
    @conversation = conversation
    @format_options = format_options
  end

  def call
    uri = URI("https://api.openai.com/v1/chat/completions")
    request = Net::HTTP::Post.new(uri)

    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer #{Rails.application.credentials.openai.api_key}"

    request_body = {
      model: "gpt-4o",
      messages: @conversation,
      temperature: 0.2,
      stream: false
    }
    if @conversation.present?
      request_body.merge!(@format_options) if @format_options.present?
      request.body = request_body.to_json

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
      puts JSON.parse(response.body)
      if !JSON.parse(response.body)["errors"].present?
        JSON.parse(response.body)["choices"][0]["message"]["content"]
      else
        puts "===============================================Sleep 60 Seconds==============================================================================="
        sleep 60
        puts "===============================================Sleep 60 Seconds==============================================================================="
      end
    else
      "No Conversations Present"
    end
  end
end
