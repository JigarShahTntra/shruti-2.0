class MarketRiskEstimationAnalysisJob < BaseJob
  include Sidekiq::Job

  def perform(idea_id, parameter)
    @idea = Idea.find_by(id: idea_id)
    analysis(parameter)
    generate_graph
  end
end
