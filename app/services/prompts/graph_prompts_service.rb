module Prompts
  class GraphPromptsService
    def initialize(conversation)
      @conversation = conversation
    end

    Graph.graph_types.keys.each do |graph_name|
      define_method "#{graph_name}" do
        @conversation["messages"] << { role: "user", content: parameter_promp(graph_name) }
      end
    end

    private

    def parameter_promp(graph_type)
      <<~PROMPT
        Analysis data I've provided and the selected chart type "#{graph_type}", please return the data in a JSON format compatible with echarts-for-react for rendering a visually effective chart.

        Ensure the response includes the key components for echarts-for-react options, such as title, tooltip, legend, xAxis, yAxis, and series, with data specifically formatted.

        The output should be structured according to the following format and use the appropriate data series, axis information, and chart elements based on the selected chart type. Provide only the JSON result, formatted and ready for direct use with echarts-for-react.
      PROMPT
    end
  end
end
