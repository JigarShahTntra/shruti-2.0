class IdeaParameterDetailSerializer < ActiveModel::Serializer
  attributes :id, :name, :cname, :description, :risk_score, :idea_parameter_recommendation_detail, :mitigation_risk_score, :idea_parameter_graphs
end
