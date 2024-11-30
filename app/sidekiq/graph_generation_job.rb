class GraphGenerationJob
  include Sidekiq::Job

  def perform(obj_id)
    parameter_detail = IdeaParameterDetail.find_by(id: obj_id)

    if parameter_detail.stage_gate_parameter.stage_gate_parameter_graphs.present?
      puts "=========== Graph Creation Started =========== \n\n"
      graph = parameter_detail.idea_parameter_graphs.new(stage_gate_parameter_graph_id: parameter_detail.stage_gate_parameter.stage_gate_parameter_graphs.last.id)
      graph.save
      puts "=========== Graph Creation Completed =========== \n\n"

      puts "=========== OpenAI Call Started =========== \n\n"
      description = OpenAiService.new(conv_prompt(parameter_detail, graph), format_options(graph)).call
      description = JSON.parse(description)
      puts "=========== OpenAI Call Completed =========== \n\n"

      puts "=========== Graph Updation Started =========== \n\n"
      graph.update(body: description)
      puts "=========== Gating Updation Completed =========== \n\n"
    else
      puts "NO GRAPH IS CONFIGURED"
    end
  end

  private

  def conv_prompt(parameter_detail, graph)
    parameter_detail.conversations.last.body << { "role": "user", "content": graph.stage_gate_parameter_graph.prompt }
  end

  def format_options(graph)
    graph.stage_gate_parameter_graph.response_format
  end
end
