class ElaborateIdeaJob
  include Sidekiq::Job

  def perform(idea_id)
    puts "=========== IDEA #{idea_id} : Ellaboration Started ==========="

    puts "=========== IDEA #{idea_id} : Idea Finding Started ==========="
    @idea = Idea.find_by(id: idea_id)
    puts "=========== IDEA #{@idea.id} : Idea Found ==========="

    puts "=========== IDEA #{@idea.id} : Prompt Create Started ==========="
    prompt = Prompts::IdeaPromptsService.new(@idea.id).elaborate
    puts "=========== IDEA #{@idea.id} : Prompt Generated ==========="

    puts "=========== IDEA - Conversation : Conversation Creation Started ==========="
    conversation = @idea.conversations.create(body: prompt)
    puts "=========== IDEA - Conversation : Conversation Created ==========="

    puts "=========== IDEA - OpenApi : AI Call Started ==========="
    content = OpenAiService.new(prompt).call
    puts "=========== IDEA - OpenApi : AI Call Completed ==========="

    puts "=========== IDEA - Conversation : Conversation Updation Started ==========="
    conversation = conversation.update(body: conversation.body << { "role": "assistant", "content": content })
    puts "=========== IDEA - Conversation : Conversation Updated ==========="

    puts "=========== IDEA : Elaboration Updation Started ==========="
    @idea.update(elaboration: content)
    puts "=========== IDEA : Elaboration Updated ==========="

    puts "=========== IDEA #{@idea.id} : Ellaboration Ended ==========="
  end
end
