class GraphsController < ApplicationController
  before_action :set_idea, :set_criteria, :set_graph

  def index
    json_graph = @graph&.attributes
    json_graph["graph_parameters"] = @graph.graph_parameters.gsub("```", "").gsub("json\n", "") if json_graph
    json_graph = {} if json_graph.nil?
    render json: json_graph, message: "Graph Fetched Successfully"
  end

  private


  # Sets the @graph instance variable to the last graph associated with the current criteria.
  def set_graph
    @graph = @criteria.graphs.last
  end

  def set_criteria
    @criteria = @idea.criterias.find_by(criteria_type: params[:criteria_type])
  end

  def set_idea
    @idea = Idea.find_by(id: params[:idea_id])
  end
end
