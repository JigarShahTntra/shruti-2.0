class RecommendationResponseFormatJob
  include Sidekiq::Job

  def perform(recommendation_id)
    recommendation = IdeaParameterRecommendationDetail.find_by(id: recommendation_id)
    if recommendation&.parameter_recommendation&.response_format&.present? && !recommendation.idea_recommendation_formats&.last&.body.present?
      puts "=========== Formatted Response Creation Started =========== \n\n"
      formatted_recommendation = recommendation.idea_recommendation_formats.new()
      formatted_recommendation.save
      puts "=========== Formatted Response Completed =========== \n\n"

      puts "=========== OpenAI Call Started =========== \n\n"
      description = OpenAiService.new(conv_prompt(recommendation), format_options(formatted_recommendation)).call
      description = JSON.parse(description)
      puts "=========== OpenAI Call Completed =========== \n\n"

      puts "=========== Formatted Response Updation Started =========== \n\n"
      formatted_recommendation.update(body: description)
      puts "=========== Formatted Response Updation Completed =========== \n\n"
    else
      "No Other Response Format Available"
    end
  end

  private

  def conv_prompt(recommendation)
    recommendation.conversations.last.body << {
      "role": "user", "content": "Please reformat the above risks and mitigation in provided strict format."
    }
  end

  def format_options(formatted_recommendation)
    formatted_recommendation.idea_parameter_recommendation_detail.parameter_recommendation.response_format
  end
end
