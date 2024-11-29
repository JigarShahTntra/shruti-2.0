class CreateParameterRecommendations < ActiveRecord::Migration[7.2]
  def change
    create_table :parameter_recommendations do |t|
      t.references :stage_gate_parameter, null: false, foreign_key: true
      t.string :name
      t.string :prompt

      t.timestamps
    end
  end
end
