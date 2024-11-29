class ParameterRecommendation < ApplicationRecord
  belongs_to :stage_gate_parameter
  validates :name, uniqueness: { scope: :stage_gate_parameter_id }
  before_save :set_name
  # after_save :create_prompt, if: -> { !description_previous_change.nil? }

  private

  def set_name
    self.name = stage_gate_parameter.name + " - Risk Mitigation Recommendation"
  end


  # def create_prompt
  #   PromptGenerationJob.perform_async(self.id, self.class.name)
  # end
end
