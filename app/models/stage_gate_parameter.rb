class StageGateParameter < ApplicationRecord
  belongs_to :stage_gate
  validates :name, uniqueness: { scope: :stage_gate_id }
  has_one :parameter_recommendation
  # after_save :create_prompt, if: -> { !description_previous_change.nil? }

  private

  # def create_prompt
  #   PromptGenerationJob.perform_async(self.id, self.class.name)
  # end
end
