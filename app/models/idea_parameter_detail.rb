class IdeaParameterDetail < ApplicationRecord
  belongs_to :stage_gate_parameter
  belongs_to :idea
  belongs_to :idea_stage_gate
  has_many :conversations, as: :conversationable, dependent: :destroy
  has_one :rating, as: :rateable, dependent: :destroy
  has_one :idea_parameter_recommendation_detail, dependent: :destroy
  has_many :idea_parameter_graphs, dependent: :destroy
  delegate :name, to: :stage_gate_parameter, prefix: false
  has_many :recommendations, as: :recommendable, dependent: :destroy

  def find_or_create_idea_parameter_recommendation_detail(attributes = {})
    idea_parameter_recommendation_detail || create_idea_parameter_recommendation_detail(attributes)
  end

  def name
    stage_gate_parameter.name
  end

  def cname
    stage_gate_parameter.cname
  end

  def self.find_by_cname(cname)
    joins(:stage_gate_parameter).where("LOWER(REPLACE(stage_gate_parameters.name, ' ', '_')) = ?", cname).last
  end

  def risk_score
    rating.value.round
  end

  def graphs
    idea_parameter_graphs.where.not(body: nil || "")
  end

  def mitigation_risk_score
    idea_parameter_recommendation_detail&.rating&.value
  end
end
