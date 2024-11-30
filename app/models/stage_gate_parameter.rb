class StageGateParameter < ApplicationRecord
  belongs_to :stage_gate
  validates :name, uniqueness: { scope: :stage_gate_id }
  has_one :parameter_recommendation
  has_many :stage_gate_parameter_graphs
  # after_save :create_prompt, if: -> { !description_previous_change.nil? }

  def cname
    name.downcase.gsub(" ", "_")
  end

  private

  # def create_prompt
  #   PromptGenerationJob.perform_async(self.id, self.class.name)
  # end
end
