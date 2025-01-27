class Idea < ApplicationRecord
  DESCRIPTIVE_FIELDS = %w[market_potential intellectual_property_potential technology_requirements compliance_aspect business_model]
  has_many :idea_stage_gates, dependent: :destroy
  has_many :stage_gates, through: :idea_stage_gates
  has_many :conversations, as: :conversationable, dependent: :destroy
  has_many :recommendations, as: :recommendable, dependent: :destroy
  enum status: {
    done: 0,
    inprogress: 1
  }
  after_save :elaborate_idea, if: -> { !description_previous_change.nil? || !market_potential_previous_change.nil? || !intellectual_property_potential_previous_change.nil? || !technology_requirements_previous_change.nil? || !compliance_aspect_previous_change.nil? || !business_model_previous_change.nil? }
  after_save :run_gates, if: -> { !elaboration_previous_change.nil? }

  def business_model_description
    idea_stage_gates.includes(:stage_gate).find_by(stage_gate: { name: "Market Risk Estimation" }).idea_parameter_details.includes(:stage_gate_parameter).find_by(stage_gate_parameter: { name: "Market Demand Analysis" })
  end

  private

  def elaborate_idea
    ElaborateIdeaJob.perform_async(self.id)
    IdeaRecommendationJob.perform_async(self.id)
  end

  def run_gates
    StageGate.all.each do |stage_gate|
      StageGateJob.perform_async(self.id, stage_gate.id)
    end
  end
end
