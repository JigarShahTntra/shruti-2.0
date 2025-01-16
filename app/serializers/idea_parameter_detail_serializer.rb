class IdeaParameterDetailSerializer < ActiveModel::Serializer
  attributes :id, :name, :cname, :description, :risk_score, :mitigation_risk_score, :graphs, :recommendations

  attribute :shruti_recommendations

  def shruti_recommendations
    response = object.idea_parameter_recommendation_detail&.idea_recommendation_formats&.last
    return nil unless response.present?
    r_response = {}
    r_response[object.stage_gate_parameter.cname] = { title: "#{object.stage_gate_parameter.name} Risk Factors and Mitigation Recommendations" }.merge(response.body)
  end
end
