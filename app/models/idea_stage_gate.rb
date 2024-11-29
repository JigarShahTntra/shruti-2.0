class IdeaStageGate < ApplicationRecord
  belongs_to :idea
  belongs_to :stage_gate
  has_many :idea_parameter_details, dependent: :destroy
  has_one :rating, as: :rateable, dependent: :destroy
end
