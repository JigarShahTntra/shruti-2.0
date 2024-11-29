class AddFieldToTables < ActiveRecord::Migration[7.2]
  def change
    add_column :stage_gate_parameters, :description, :string
    add_column :parameter_recommendations, :description, :string
  end
end
