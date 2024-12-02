class IdeaParameterRecommendationDetail < ApplicationRecord
  belongs_to :idea_parameter_detail
  belongs_to :parameter_recommendation
  has_many :conversations, as: :conversationable, dependent: :destroy
  has_one :rating, as: :rateable, dependent: :destroy
  has_many :idea_recommendation_formats, dependent: :destroy
end
