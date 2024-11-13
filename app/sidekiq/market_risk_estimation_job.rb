class MarketRiskEstimationJob
  include Sidekiq::Job

  def perform(idea_id)
    Criteria.criteria_types.keys.each do |parameter|
      puts "=========== IDEA: #{idea_id} : #{parameter} Analysis Started ==========="
      MarketRiskEstimationAnalysisJob.perform_async(idea_id, parameter)
      puts "=========== IDEA: #{idea_id} : #{parameter} Analysis Ended ==========="
    end
  end
end
