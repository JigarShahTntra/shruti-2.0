class AddStatusFieldToIdea < ActiveRecord::Migration[7.2]
  def change
    add_column :ideas, :status, :integer
  end
end
