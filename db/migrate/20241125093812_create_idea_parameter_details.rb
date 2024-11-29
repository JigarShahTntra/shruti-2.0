class CreateIdeaParameterDetails < ActiveRecord::Migration[7.2]
  def change
    create_table :idea_parameter_details do |t|
      t.references :stage_gate_parameter, null: false, foreign_key: true
      t.references :idea, null: false, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
