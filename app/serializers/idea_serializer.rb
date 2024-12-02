class IdeaSerializer < ActiveModel::Serializer
  attributes :id
  has_many :recommendations
end
