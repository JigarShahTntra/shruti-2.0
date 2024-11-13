module Prompts
  class MitigationPromptsService
    def initialize(conversation)
      @conversation = conversation
    end

    def call
      @conversation["messages"] << { role: "user", content: mitigation_prompt }
    end

    private

    def mitigation_prompt
      <<~PROMPT
        Based on the previous analysis, please provide a detailed mitigation strategy.

        For each identified risk area, outline actionable steps to improve the innovation's position and maximize success potential. Specifically, address any challenges in analysis with recommendations that include:

        Risk Summary: Briefly describe the identified risk or challenge.
        Mitigation Action: A detailed action plan to reduce this risk.
        Expected Impact: Explain how this mitigation will enhance market position or reduce risk level.

        Ensure that the response is practical and reflects strategies commonly recommended by experienced business analysts for market risk mitigation.
      PROMPT
    end
  end
end
