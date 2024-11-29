class PromptGenerationJob
  include Sidekiq::Job

  def perform(parameter_id, class_name)
    puts "=========== Prompt Generation for Parameter #{parameter_id} Started =========== \n\n"
    parameter = class_name.constantize.find_by(id: parameter_id)
    puts "=========== Parameter Found =========== \n\n"
    prompt_conversation = PromptGenerationService.new(parameter).generate
    puts "=========== Prompt Conversation #{prompt_conversation} Done =========== \n\n"
    puts "=========== OpenAiService Called =========== \n\n"
    prompt = OpenAiService.new(prompt_conversation).call
    puts "=========== OpenAiService done =========== \n\n"
    puts "=========== Result #{prompt} =========== \n\n"
    parameter.update(prompt:)
    puts "=========== Parameter Updated Successfully #{parameter.name}:#{parameter.id} =========== \n\n"
  end
end
