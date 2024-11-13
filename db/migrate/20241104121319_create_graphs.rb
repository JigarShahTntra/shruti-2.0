class CreateGraphs < ActiveRecord::Migration[7.2]
  def change
    create_table :graphs do |t|
      t.references :criteria, null: false, foreign_key: true
      t.integer :graph_type
      t.json :graph_parameters
      t.string :description
      t.timestamps
    end
  end
end
