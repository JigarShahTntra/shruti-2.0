module Prompts
  class MarketGatePromptsService < BasePromptsService
    Criteria.criteria_types.keys.each do |method_name|
      define_method "#{method_name}" do
        conversation_json << { "role": "user", "content": send("#{method_name}_prompt") }
      end
    end

    private

    def conversation_json
      [
        { "role": "system", "content": "You are an experienced business analyst conducting a Market Analysis for a new innovation." }
      ]
    end

    def market_demand_prompt
      <<~PROMPT
        You are an experienced business analyst conducting a Market Demand Analysis for a new innovation.

        Refined Idea:
        "#{@idea.ellaboration}"

        Analyze the market demand by providing detailed insights into the following:

        1. Total Addressable Market (TAM): Estimate the overall market size by calculating the total revenue opportunity available if the innovation achieves 100% market penetration. Include an explanation of the calculation and the total addressable market value.

        2. Serviceable Available Market (SAM): Estimate the market size that can realistically be targeted and reached by the innovation based on current market accessibility. Provide an explanation of the calculation and the serviceable available market value.

        3. Serviceable Obtainable Market (SOM): Calculate the potential portion of the SAM that the innovation can capture within a set period, considering market competition and practical constraints. Explain the assumptions made for this estimation and provide the final SOM value.

        4. Customer Segments, Growth Rates, and Demographic Data: Identify key customer segments, market growth rates, and relevant demographic data. Include any insights on trends or shifts in customer behavior that might affect the market demand for this innovation.

        5. Market Demand Score: Based on the TAM, SAM, SOM, and customer insights, assign a Market Demand Score that reflects the innovation’s relevance and potential in the market. Provide a rationale for this score.

        Structure the response as a professional analysis, with each section clearly labeled and supported by explanations, insights, and data-driven assumptions. Include clear explanations for each term (TAM, SAM, SOM) to ensure clarity.
      PROMPT
    end

    def competetive_landscape_prompt
      <<~PROMPT
        You are an experienced business analyst conducting a Competitive Landscape Analysis for a new innovation.

        Refined Idea:
        "#{@idea.ellaboration}"

        Analyze the competitive landscape by addressing the following:

        1. Identify Primary Competitors: Identify the main competitors in the market relevant to this innovation. For each competitor, estimate their market share as a percentage of the total addressable market. Explain the basis for these estimates, such as competitor sales, user base, or industry reports, if applicable.

        2. Competitive Differentiation: For each primary competitor, analyze their unique differentiators in terms of features, product positioning, customer targeting, and other strengths that set them apart. Summarize each competitor’s key differentiators in a concise format.

        3. Feature Analysis and Market Overlap: Assess how the innovation compares to each competitor in terms of overlapping features, functionality, and target market. Identify any gaps or unique features that could give the innovation an edge or present potential risks.

        4. Competitive Risk Score: Based on the level of differentiation, feature analysis, and market overlap, calculate a Competitive Risk Score to assess the risk level posed by competitors. Provide this score as a percentage, with clear indications of whether it represents high, medium, or low competitive risk. Include a brief rationale for the score, explaining which factors contributed most significantly to the risk level.

        Structure your response professionally, with each section clearly labeled and supported by data-driven assumptions, industry insights, or logical reasoning. Summarize findings to help decision-makers understand the competitive landscape.
      PROMPT
    end

    def customer_acceptance_prompt
      <<~PROMPT
        You are an experienced business analyst conducting a Customer Acceptance Potential analysis for an innovation.

        Refined Idea:
        "#{@idea.ellaboration}"

        Please analyze the customer acceptance potential by addressing the following:

        1. Estimate Customer Acceptance: Assess the likely customer acceptance of this innovation based on indicators such as:
          - Adoption Rates: Estimate potential adoption rates for target customer segments.
          - Customer Satisfaction Score (CSAT): Project potential satisfaction levels based on similar products or industry benchmarks.
          - Net Promoter Score (NPS): Estimate the likelihood of customers recommending this innovation to others.

          Provide an overall Customer Acceptance Score as a percentage or on a scale, indicating high, medium, or low potential acceptance.

        2. Recommendations for Improving Customer Relevance: Based on the initial acceptance assessment, provide actionable recommendations to enhance the innovation’s relevance to customers. For each recommendation:
          - Describe the suggested change (e.g., feature enhancement, price adjustment, targeted marketing).
          - Explain how and why this change may increase customer acceptance.

        3. Expected Impact of Recommendations: For each recommendation, include an "Expected Impact" label. Estimate the projected improvement in customer acceptance if the recommendation is implemented (e.g., "Expected to increase Customer Acceptance Score by 15%").

        Structure the recommendations in a checklist format, with clear explanations and actionable steps. Use data-driven reasoning or logical assumptions where applicable, and present findings in a concise and professional format to guide strategic decision-making.
      PROMPT
    end

    def market_entry_barriers_prompt
      <<~PROMPT
        You are an experienced business analyst assessing the market entry barriers for a new innovation.

        Refined Idea:
        "#{@idea.ellaboration}"

        Please analyze the market entry barriers, addressing the following criteria:

        1. Identify and Assess Entry Barriers: Determine the primary barriers to market entry for this innovation. Specifically:
          - Assess the need for strategic partnerships and the potential complexity of establishing these relationships.
          - Evaluate high costs or financial constraints, such as capital requirements, operational costs, or regulatory fees.
          - Identify any additional barriers such as regulatory challenges, infrastructure needs, or competitive pressure.

          Provide an Entry Barriers Score that indicates the overall difficulty of entering the market as "High," "Moderate," or "Low."

        2. Actionable Recommendations to Overcome High-Risk Barriers: For each barrier identified, provide targeted, actionable insights to help mitigate or reduce the risk. Include:
          - Partnership Recommendations: Suggest specific types of partnerships or collaborators that could help reduce entry difficulty (e.g., distribution partners, regulatory advisors, financial backers).
          - Cost Mitigation Strategies: Provide recommendations to offset high initial costs, such as phased market entry, alternative funding sources, or cost-sharing opportunities.
          - Solutions for Other High-Risk Barriers: For other significant barriers, suggest steps to address regulatory compliance, infrastructure needs, or competitive positioning.

        3. Expected Impact of Each Recommendation: For each recommendation, include an "Impact Level" tag that estimates the potential reduction in entry difficulty (e.g., "Expected to reduce Entry Barriers Score to Moderate").

        Please structure your analysis in a professional format with concise explanations, ensuring each recommendation is clear and actionable. Use logical reasoning or data-driven assumptions as needed to support each insight.
      PROMPT
    end

    def revenue_potential_forecast_prompt
      <<~PROMPT
        You are a skilled business analyst performing a revenue potential forecast for a new innovation.

        Refined Idea:
        "#{@idea.ellaboration}"

        Please generate a comprehensive forecast for this innovation's revenue potential based on the following criteria:

        1. Revenue Forecast: Using current market data and the projected customer appeal of this innovation:
          - Estimate the potential revenue over different time periods (e.g., 1 year, 5 years).
          - Include a breakdown of anticipated revenue streams if applicable (e.g., subscriptions, product sales, service fees).

          Display this forecast as a Revenue Potential Graph, indicating expected revenue growth over time.

        2. Return on Investment (ROI) Projection:
          - Calculate the expected ROI based on the projected revenue over time, considering both initial and ongoing investment costs.
          - Display the ROI figure alongside a gauge that indicates the estimated timeline for reaching profitability (e.g., break-even point, high-profit phase).

        3. Enhanced ROI Projections with Strategic Recommendations:
          - Suggest specific strategic changes or improvements (e.g., market targeting, pricing adjustments, customer engagement strategies) that could further enhance ROI.
          - For each recommendation, provide an “Increased ROI” projection that shows how implementing the changes could positively impact revenue growth and the profitability timeline.

        Please structure the analysis in a professional format with detailed explanations for each projection, and ensure all data points are logically reasoned or supported by market assumptions.
      PROMPT
    end

    def global_and_local_trends
    end
  end
end
