class IdeaStageGateSerializer < ActiveModel::Serializer
  attributes :id, :cname, :total_rating, :total_mitigation_rating
  has_many :idea_parameter_details
end
