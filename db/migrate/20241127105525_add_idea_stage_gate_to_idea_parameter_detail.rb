class AddIdeaStageGateToIdeaParameterDetail < ActiveRecord::Migration[7.2]
  def change
    add_reference :idea_parameter_details, :idea_stage_gate, null: false, foreign_key: true
  end
end
