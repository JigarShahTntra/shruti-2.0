class IdeaParameterRecommendationJob
  include Sidekiq::Job

  def perform(parameter_id)
    @parameter = IdeaParameterDetail.find_by(id: parameter_id)

    puts "=========== Recommendation Creation Started =========== \n\n"

    puts "=========== OpenAiService Called =========== \n\n"
    prompt = OpenAiService.new(conversation, format_options).call
    puts "=========== OpenAiService done =========== \n\n"

    description = JSON.parse(prompt)

    description["recommendations"].each do |recom|
      @parameter.recommendations.create(recom)
    end
    puts "=========== Recommendation Creation Completed =========== \n\n"
  end

  private

  def conversation
    @parameter.conversations.last.body << {
      "role": "user",
      "content": "On the basis of previous analysis, provide me some advanced 6 recommendations to consider in the parameter of #{@parameter.stage_gate_parameter.name}, Please provide the response in the strict format."
    }
  end

  def format_options
    {
      "response_format": {
        "type": "json_schema",
        "json_schema": {
            "name": "idea_recommendation_schema",
            "schema": {
                "type": "object",
                "properties": {
                    "recommendations": {
                        "type": "array",
                        "items": {
                            "type": "object",
                            "properties": {
                                "title": {
                                  "type": "string",
                                  "description": "single liner title for the recommendation."
                                },
                                "description": {
                                  "type": "string",
                                  "description": "2 liner description of the recommendation."
                                }
                            }
                        }
                    }
                }
            }
        }
      }
    }
  end
end
