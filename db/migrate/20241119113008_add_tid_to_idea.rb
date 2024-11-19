class AddTidToIdea < ActiveRecord::Migration[7.2]
  def change
    add_column :ideas, :tid, :string
    add_column :ideas, :market_potential, :string
  end
end
