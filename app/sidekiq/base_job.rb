require "net/http"
require "uri"
require "json"

class BaseJob
  include Sidekiq::Job

  private

  def requests(conversation_array, conversation_type = "", var_name = "@idea", skip = false)
    uri = URI("https://api.openai.com/v1/chat/completions")
    request = Net::HTTP::Post.new(uri)

    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer #{Rails.application.credentials.openai.api_key}"

    request.body = {
      model: "gpt-4o",
      messages: conversation_array,
      stream: false
    }.to_json
    eval(var_name).idea_conversations.create(conversation: request.body, conversation_type:) unless skip
    puts "=========== #{eval(var_name).class unless skip}|#{eval(var_name).id unless skip} : #{conversation_type.humanize} Request Started ===========" unless skip
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
    parsed_response = JSON.parse(response.body)
    dup_body = JSON.parse(request.body)
    dup_body["messages"] << parsed_response["choices"][0]["message"]
    eval(var_name).idea_conversations.create(conversation: dup_body, conversation_type:) unless skip
    puts "=========== #{eval(var_name).class unless skip}|#{eval(var_name).id unless skip} : #{conversation_type.humanize} Request Ended ==========="
    parsed_response["choices"][0]["message"]["content"]
  end

  def analysis(type)
    @criteria = @idea.criterias.new(criteria_type: type)
    @criteria.save
    criteria_prompt = requests(Prompts::MarketGatePromptsService.new(@idea.id).send(type), type, "@criteria")
    @criteria.update(description: criteria_prompt)
    puts "=========== CRITERIA #{@criteria.id} : #{@criteria.criteria_type.humanize} Mitigation Started ==========="
    MarketRiskMitigationJob.perform_async(@criteria.id)
    puts "=========== CRITERIA #{@criteria.id} : #{@criteria.criteria_type.humanize} Mitigation Ended ==========="
    @criteria
  end

  def generate_graph
    conversation = @criteria.idea_conversations.last.conversation
    graph_type = requests(Prompts::DecideGraphsPromptsService.new(conversation).which_graph, conversation_type = "", var_name = "", skip=true)
    puts graph_type
    graph_type = graph_type.gsub('"', "").underscore
    @graph = @criteria.graphs.new(graph_type: graph_type)
    @graph.save
    @graph.update(graph_parameters: requests(Prompts::GraphPromptsService.new(conversation).send(@graph.graph_type),
    conversation_type = @criteria.criteria_type, var_name = "@graph"))
    @graph.update(description: requests(Prompts::DecideGraphsPromptsService.new(conversation).description, conversation_type = @criteria.criteria_type, var_name = "@graph"))
    @graph
  end
end
