class EllaborateIdeaJob < BaseJob
  include Sidekiq::Job

  def perform(idea_id)
    @idea = Idea.find_by(id: idea_id)
    puts "=========== IDEA #{@idea.id} : Ellaboration Started ==========="
    @idea.ellaboration = requests(Prompts::IdeaPromptsService.new(@idea.id).ellaborate, conversation_type = "idea", var_name = "@idea")
    puts "=========== IDEA #{@idea.id} : Ellaboration Ended ==========="
    @idea.save
  end
end
