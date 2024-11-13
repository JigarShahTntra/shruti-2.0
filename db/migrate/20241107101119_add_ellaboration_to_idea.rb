class AddEllaborationToIdea < ActiveRecord::Migration[7.2]
  def change
    add_column :ideas, :ellaboration, :string
  end
end
