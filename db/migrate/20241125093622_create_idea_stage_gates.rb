class CreateIdeaStageGates < ActiveRecord::Migration[7.2]
  def change
    create_table :idea_stage_gates do |t|
      t.references :idea, null: false, foreign_key: true
      t.references :stage_gate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
