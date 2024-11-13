module Prompts
  class DecideGraphsPromptsService
    def initialize(conversation)
      @conversation = conversation
    end

    def which_graph
      @conversation["messages"] << { role: "user", content: prompt_for_graph }
    end

    def description
      @conversation["messages"] << { role: "user", content: prompt_for_graph_description }
    end

    private

    def prompt_for_graph
      <<~PROMPT
        Please provide a suggestion for the most suitable chart type to visually represent this data. Choose only one of the following chart types and return your answer as a single word from the same list because it's case sensetive:
        pie_chart, bar_chart, line_chart, scatter_chart, sparkline_chart, gauge_chart, heatmap_chart.
      PROMPT
    end

    def prompt_for_graph_description
      <<~PROMPT
        Please provide the explaination of the data represented in the graph.
      PROMPT
    end
  end
end
