class IdeaStageGate < ApplicationRecord
  belongs_to :idea
  belongs_to :stage_gate
  has_many :idea_parameter_details, dependent: :destroy
  has_one :rating, as: :rateable, dependent: :destroy

  delegate :name, to: :stage_gate, prefix: false

  def self.find_by_cname(cname)
    joins(:stage_gate).where("LOWER(REPLACE(stage_gates.name, ' ', '_')) = ?", StageGate.first.cname).last
  end

  def total_rating
    idea_parameter_details.joins(:rating).sum("ratings.value").to_f / idea_parameter_details.count
  end

  def cname
    stage_gate.cname
  end

  def total_mitigation_rating
    idea_parameter_details.joins(idea_parameter_recommendation_detail: :rating).sum("ratings.value").to_f / idea_parameter_details.count
  end
end
