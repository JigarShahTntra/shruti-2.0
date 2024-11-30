class CreateStageGateParameterGraphs < ActiveRecord::Migration[7.2]
  def change
    create_table :stage_gate_parameter_graphs do |t|
      t.references :stage_gate_parameter, null: false, foreign_key: true
      t.string :prompt
      t.jsonb :response_format

      t.timestamps
    end
  end
end
