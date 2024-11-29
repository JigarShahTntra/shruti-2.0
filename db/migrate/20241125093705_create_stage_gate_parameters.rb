class CreateStageGateParameters < ActiveRecord::Migration[7.2]
  def change
    create_table :stage_gate_parameters do |t|
      t.references :stage_gate, null: false, foreign_key: true
      t.string :name
      t.string :prompt

      t.timestamps
    end
  end
end
