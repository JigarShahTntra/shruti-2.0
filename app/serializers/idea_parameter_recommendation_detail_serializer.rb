class IdeaParameterRecommendationDetailSerializer < ActiveModel::Serializer
  attributes :id
  has_many :idea_recommendation_formats
end
