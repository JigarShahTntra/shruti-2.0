class MarketRiskMitigationJob < BaseJob
  include Sidekiq::Job

  def perform(criteria_id)
    @criteria = Criteria.find_by(id: criteria_id)
    puts "=========== CRITERIA MITIGATION #{@criteria.id} : #{@criteria.criteria_type.humanize} Started ==========="
    raw_conversation = @criteria.idea_conversations.last.conversation
    if raw_conversation.class != String
      raw_conversation = raw_conversation.to_json
    end
    conversation = JSON.parse(raw_conversation)
    @criteria.criteria_mitigations.new(title: "#{@criteria.criteria_type.humanize} Mitigation", description: requests(Prompts::MitigationPromptsService.new(conversation).call, conversation_type = @criteria.criteria_type, var_name="@criteria")).save
    puts "=========== CRITERIA MITIGATION #{@criteria.id} : #{@criteria.criteria_type.humanize} Completed ==========="
  end
end
