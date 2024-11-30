class IdeaParameterDetail < ApplicationRecord
  belongs_to :stage_gate_parameter
  belongs_to :idea
  belongs_to :idea_stage_gate
  has_many :conversations, as: :conversationable, dependent: :destroy
  has_one :rating, as: :rateable, dependent: :destroy
  has_one :idea_parameter_recommendation_detail, dependent: :destroy

  delegate :name, to: :stage_gate_parameter, prefix: false

  def find_or_create_idea_parameter_recommendation_detail(attributes = {})
    idea_parameter_recommendation_detail || create_idea_parameter_recommendation_detail(attributes)
  end

  def name
    stage_gate_parameter.name
  end

  def risk_score
    rating.value
  end

  def mitigation_risk_score
    idea_parameter_recommendation_detail&.rating&.value
  end
end
