class PromptGenerationService
  def initialize(parameter = "")
    @parameter = parameter
    @description = @parameter.description
    @class_name = @parameter.class
  end

  def generate
    if @class_name == StageGateParameter
      common_prompt << { role: "user", content: deciding_prompt }
    elsif @class_name == ParameterRecommendation
      common_prompt << { role: "user", content: recommendation_prompt }
    end
  end

  private

  def common_prompt
    [ { role: "system", content: "You are an AI assistant specialized in creating dynamic prompts for analytical studies. I will provide you with a parameter description. Your task is to generate a reusable and detailed input prompt that can analyze any innovative idea based on the given parameter." } ]
  end

  def recommendation_prompt
    <<~PROMPT
      Requirements for the Output Prompt:

      #{@description}
      Consider it in aspects of #{@parameter.stage_gate_parameter.name} parameter.

      Output Required: A reusable input prompt with placeholders for Risks and Mitigations Recommendations.
    PROMPT
  end

  def deciding_prompt
    <<~PROMPT
      Requirements for the Output Prompt:

      The prompt should include placeholders for the user to insert their innovative idea.
      The prompt should guide the AI to deliver a structured and detailed analysis based on the parameter description.
      The analysis should be actionable, clear, and relevant to the parameter provided.
      Input Details:

      Parameter Description: #{@description}
      Output Required: A reusable input prompt with placeholders for innovative ideas.
    PROMPT
  end
end
