class CreateIdeaParameterGraphs < ActiveRecord::Migration[7.2]
  def change
    create_table :idea_parameter_graphs do |t|
      t.references :stage_gate_parameter_graph, null: false, foreign_key: true
      t.jsonb :body
      t.references :idea_parameter_detail, null: false, foreign_key: true

      t.timestamps
    end
  end
end
