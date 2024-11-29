class RatingJob
  include Sidekiq::Job

  def perform(obj_id, obj_name)
    obj = obj_name.constantize.find_by(id: obj_id)

    puts "=========== Rating Creation Started =========== \n\n"
    rating = obj.build_rating
    rating.save
    puts "=========== Rating Creation Completed =========== \n\n"

    puts "=========== OpenAI Call Started =========== \n\n"
    description = OpenAiService.new(conv_prompt(obj), format_options).call
    description = JSON.parse(description)
    puts "=========== OpenAI Call Completed =========== \n\n"

    puts "=========== Rating Updation Started =========== \n\n"
    rating.update(value: description["rating"], description: description["explanation"])
    puts "=========== Rating Updation Completed =========== \n\n"
  end

  private

  def conv_prompt(obj)
    if obj.class.eql?(IdeaParameterDetail)
        conversation = if obj.stage_gate_parameter.name == "TAM, SAM, SOM Analysis"
          obj.idea.business_model_description.conversations.last.body
        else
          obj.conversations.last.body
        end

        previous_conversation = conversation << format_assistant
        previous_conversation << {
          "role": "user",
          "content": <<-PROMPT
            On the basis of analysis please evaluate the Risk Score.
            100% stands for the maximum risk
            0% stands for no risk

            Please also provide the explaination of the Risk Score calculation explaination.
          PROMPT
        }
    elsif obj.conversations&.last&.body.present? && obj.class.eql?(IdeaParameterRecommendationDetail)
      previous_conversation = obj.conversations.last.body << format_assistant
      previous_conversation << {
        "role": "user",
        "content": <<-PROMPT
          Risk Score without considering mitigation recommendation is #{obj.idea_parameter_detail.rating.value}

          Provide me the risk score after considering the mitigation recommendations that how it risk has been mitigated using the recommendations.

          100% stands for the maximum risk
          0% stands for no risk

          Please also provide the explaination of the Risk Score calculation explaination.
        PROMPT
      }
    end
  end

  def format_assistant
    {
      "role": "system",
      "content": "Respond strictly in the following JSON format:\n{\n  \"rating\": integer (percentage between 0 and 100),\n  \"explanation\": string\n}"
    }
  end

  def format_options
    {
      "response_format": {
        "type": "json_schema",
        "json_schema": {
          "name": "rating_schema",
          "schema": {
            "type": "object",
            "properties": {
              "rating": {
                "type": "integer",
                "minimum": 0,
                "maximum": 100
              },
              "explanation": {
                "type": "string"
              }
            },
            "required": [ "rating", "explanation" ]
          }
        }
      }
    }
  end
end
