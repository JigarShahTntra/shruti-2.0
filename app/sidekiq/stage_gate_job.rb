require "redcarpet"
require "redcarpet/render_strip"

class StageGateJob
  include Sidekiq::Job

  def perform(idea_id, stage_gate_id)
    puts "=========== StageGate Fetching Started =========== \n\n"
    stage_gate = StageGate.find_by(id: stage_gate_id)
    puts "=========== StageGate Fetched Successfully =========== \n\n"

    puts "=========== Idea Fetching Started =========== \n\n"
    idea = Idea.find_by(id: idea_id)
    puts "=========== Idea Fetched Successfully =========== \n\n"

    puts "=========== Process for #{stage_gate.name} Stage Gate Started =========== \n\n"

    puts "=========== Idea Stage Gate Creation Started =========== \n\n"
    idea_stage_gate = idea.idea_stage_gates.find_or_create_by(stage_gate_id: stage_gate.id)
    puts "=========== Idea Stage Gate Creation Completed =========== \n\n"

    puts "=========== Parameter Processing Started =========== \n\n"
    idea_stage_gate.stage_gate.stage_gate_parameters.each do |stage_gate_parameter|
      if stage_gate_parameter.name == "TAM, SAM, SOM Analysis"
        puts "=========== #{stage_gate_parameter.name} Parameter Processing Started =========== \n\n"
        idea_parameter = idea_stage_gate.idea_parameter_details.create(stage_gate_parameter_id: stage_gate_parameter.id, idea_id: idea.id)
        description = idea.business_model_description&.description
        idea_parameter.update(description:)
        puts "=========== #{stage_gate_parameter.name} Parameter Processing Completed =========== \n\n"
        puts "=========== Force NEXT =========== \n\n"
        next
      end
      puts "=========== #{stage_gate_parameter.name} Parameter Processing Started =========== \n\n"

      puts "=========== Idea Parameter Creation Started =========== \n\n"
      idea_parameter = idea_stage_gate.idea_parameter_details.find_or_create_by(stage_gate_parameter_id: stage_gate_parameter.id, idea_id: idea.id)

      puts "=========== Conversation Prompt Started =========== \n\n"
      conv_prompt = conversation_prompt(stage_gate_parameter, idea)
      puts "=========== Conversation Prompt Completed =========== \n\n"

      puts "=========== Conversation Creation Started =========== \n\n"
      conversation = idea_parameter.conversations.find_or_create_by(body: conv_prompt)
      puts "=========== Conversation Creation Completed =========== \n\n"

      if idea_parameter.description.present?
        puts "=========== No Need Of API Call As Already Present =========== \n\n"
      else
        puts "=========== OpenAI Call Started =========== \n\n"
        description = OpenAiService.new(conv_prompt).call
        puts "=========== OpenAI Call Completed =========== \n\n"

        puts "=========== Conversation Updation Started =========== \n\n"
        conversation.update(body: conversation.body << { "role": "assistant", "content": description })
        puts "=========== Conversation Updation Completed =========== \n\n"

        puts "=========== Idea Parameter Updation Started =========== \n\n"
        idea_parameter.update(description:)
        puts "=========== Idea Parameter Updation Completed =========== \n\n"
        
        puts "=========== Idea Parameter Rating Started =========== \n\n"
        RatingJob.perform_async(idea_parameter.id, "IdeaParameterDetail")
        puts "=========== Idea Parameter Rating Completed =========== \n\n"
      end

      puts "=========== #{stage_gate_parameter.name} Parameter Processing Completed =========== \n\n"

      puts "=========== #{stage_gate_parameter.name} Recommendation Processing Started =========== \n\n"
      if stage_gate_parameter.parameter_recommendation.present?
        puts "=========== Idea Parameter Recommendation Creation Started =========== \n\n"
        recommendation = idea_parameter.find_or_create_idea_parameter_recommendation_detail(parameter_recommendation_id: stage_gate_parameter.parameter_recommendation.id)
        puts "=========== Idea Parameter Recommendation Creation Completed =========== \n\n"

        puts "=========== Idea Parameter Recommendation Prompt Started =========== \n\n"
        recom_prompt = conversation.body << { "role": "user", "content": stage_gate_parameter.parameter_recommendation.prompt }
        puts "=========== Idea Parameter Recommendation Prompt Completed =========== \n\n"

        if recommendation.description.present?
          puts "=========== No Need Of API Call As Already Present =========== \n\n"
        else
          puts "=========== Conversation Creation For Recommendation Started =========== \n\n"
          recom_conv = recommendation.conversations.find_or_create_by(body: recom_prompt)
          puts "=========== Conversation Creation For Recommendation Completed =========== \n\n"

          puts "=========== OpenAI Call For Recommendation Started =========== \n\n"
          recom_description = OpenAiService.new(recom_prompt).call
          puts "=========== OpenAI Call For Recommendation Completed =========== \n\n"

          puts "=========== Conversation Updation For Recommendation Started =========== \n\n"
          recom_conv.update(body: recom_conv.body << { "role": "assistant", "content": recom_description })
          puts "=========== Conversation Updation For Recommendation Completed =========== \n\n"

          puts "=========== Idea Parameter Recommendation Updation Started =========== \n\n"
          recommendation.update(description: recom_description)
          puts "=========== Idea Parameter Recommendation Updation Completed =========== \n\n"

          puts "=========== Idea Parameter Recommendation Rating Started =========== \n\n"
          RatingJob.perform_async(recommendation.id, "IdeaParameterRecommendationDetail")
          puts "=========== Idea Parameter Recommendation Rating Completed =========== \n\n"
        end
      end
      puts "=========== #{stage_gate_parameter.name} Recommendation Processing Started =========== \n\n"
    end
    puts "=========== Parameter Processing Completed =========== \n\n"
    puts "=========== Process for #{stage_gate.name} Stage Gate Completed =========== \n\n"
  end

  private

  def conversation_prompt(stage_gate_parameter, idea)
    prompt = stage_gate_parameter.prompt
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::StripDown)
    elaboration_text = markdown.render(idea.elaboration)
    [
      { "role": "assistant", "content": prompt.lines.first.gsub("\n", "") },
      { "role": "user", "content": prompt.gsub("{description}", elaboration_text) }
    ]
  end
end
