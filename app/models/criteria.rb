class Criteria < ApplicationRecord
  has_many :idea_conversations, as: :idea_conversationable, dependent: :destroy
  has_many :criteria_ratings, dependent: :destroy
  belongs_to :idea
  has_many :graphs, dependent: :destroy
  has_many :criteria_mitigations, dependent: :destroy
  enum :criteria_type, { market_demand: 0, competetive_landscape: 1, customer_acceptance: 2, market_entry_barriers: 3, revenue_potential_forecast: 4 }
end
