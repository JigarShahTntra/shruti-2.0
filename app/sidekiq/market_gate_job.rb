class MarketGateJob < BaseJob
  include Sidekiq::Job

  def perform(idea_id)
    MarketRiskEstimationJob.perform_async(idea_id)
  end
end
