class IdeaConversation < ApplicationRecord
  belongs_to :idea_conversationable, polymorphic: true

  enum :conversation_type, { idea: 0, market_demand: 1, competetive_landscape: 2, customer_acceptance: 3, market_entry_barriers: 4, revenue_potential_forecast: 5 }
end
