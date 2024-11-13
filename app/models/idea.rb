class Idea < ApplicationRecord
  has_many :idea_histories, dependent: :destroy
  has_many :idea_conversations, as: :idea_conversationable, dependent: :destroy
  has_many :criterias, dependent: :destroy
  before_update :create_history
  after_save :ellaborate_idea, if: -> { !description_previous_change.nil? }
  after_save :run_market_gate, if: -> { !ellaboration_previous_change.nil? }

  private

  def create_history
    self.idea_histories.create(description: self.description)
  end


  def ellaborate_idea
    EllaborateIdeaJob.perform_async(self.id)
  end

  def run_market_gate
    MarketGateJob.perform_async(self.id)
  end
end
