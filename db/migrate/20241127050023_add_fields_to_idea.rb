class AddFieldsToIdea < ActiveRecord::Migration[7.2]
  def change
    add_column :ideas, :market_potential, :string
    add_column :ideas, :intellectual_property_potential, :string
    add_column :ideas, :technology_requirements, :string
    add_column :ideas, :compliance_aspect, :string
    add_column :ideas, :business_model, :string
  end
end
