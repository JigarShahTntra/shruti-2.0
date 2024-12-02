class IdeaRecommendationJob
  include Sidekiq::Job

  def perform(idea_id)
    @idea = Idea.find_by(id: idea_id)

    puts "=========== Recommendation Creation Started =========== \n\n"

    puts "=========== OpenAiService Called =========== \n\n"
    prompt = OpenAiService.new(conversation, format_options).call
    puts "=========== OpenAiService done =========== \n\n"

    description = JSON.parse(prompt)

    description["recommendations"].each do |recom|
      @idea.recommendations.create(recom)
    end
    puts "=========== Recommendation Creation Completed =========== \n\n"
  end

  private

  def conversation
    [
      {
        "role": "assistant",
        "content": "You're an business analyst expert."
      },
      {
        "role": "user",
        "content": <<-PROMPT
          On the basis of below description of the idea, provide me some advance recommendations to consider in the Innovative Idea, Please provide the response in the strict format.

          Description:
          #{@idea.description}

          #{described_fields}
        PROMPT
      }
    ]
  end

  def described_fields
    Idea::DESCRIPTIVE_FIELDS.map do |field|
      "#{field.humanize} described by user \n " + @idea.send(field) if @idea.send(field).present? && @idea.send(field).length > 5
    end.compact.join("\n")
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
