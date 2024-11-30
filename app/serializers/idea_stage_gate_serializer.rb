class IdeaStageGateSerializer < ActiveModel::Serializer
  attributes :id, :cname, :total_rating, :total_mitigation_rating
  has_many :idea_parameter_details

  # def idea_parameter_details
  #   object.idea_parameter_details.map do |detail|
  #     { detail.name => IdeaParameterDetailSerializer.new(detail, scope: scope).as_json }
  #   end
  # end
end
