module Prompts
  class IdeaPromptsService
    def initialize(idea_id)
      @idea = Idea.find_by(id: idea_id)
    end

    def elaborate
      conversation_json << { "role": "user", "content": elaborate_prompt }
    end

    private

    def conversation_json
      [
        { "role": "system", "content": "You are a business analyst specializing in professional business proposal preparation." }
      ]
    end


    def elaborate_prompt
      <<~PROMPT
        You are an experienced business analyst with expertise in transforming raw ideas into professional business concepts.

        The user has provided the following rough idea:
        Description
        "#{@idea.description}"

        "#{described_fields}"

        Transform this idea into a refined, professional business proposal that includes the following sections:
        1. Concept Overview: A clear and concise summary of the idea.
        2. Value Proposition: What unique value does this idea offer to the target audience or market?
        3. Target Audience: Describe the primary audience or market segments that would benefit from this idea.
        4. Core Features or Components: List the main features, functionalities, or components of the idea.
        5. Potential Benefits: Describe how this idea could impact the target audience, including any tangible or intangible benefits.

        Structure the response so that it reads clearly and professionally, as though prepared by a seasoned business analyst.
      PROMPT
    end

    def described_fields
      Idea::DESCRIPTIVE_FIELDS.map do |field|
        "#{field.humanize} described by user \n " + @idea.send(field) if @idea.send(field).present? && @idea.send(field).length > 5
      end.compact.join("\n")
    end
  end
end
