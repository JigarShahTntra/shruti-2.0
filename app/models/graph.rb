class Graph < ApplicationRecord
  belongs_to :criteria
  has_many :idea_conversations, as: :idea_conversationable, dependent: :destroy
  enum :graph_type, { pie_chart: 0, bar_chart: 1, line_chart: 2, scatter_chart: 3, sparkline_chart: 4, gauge_chart: 5, heatmap_chart: 6 }
end
