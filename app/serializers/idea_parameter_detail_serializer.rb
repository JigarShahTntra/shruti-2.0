class IdeaParameterDetailSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :risk_score, :idea_parameter_recommendation_detail, :mitigation_risk_score
end
