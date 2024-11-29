class AddDescriptionToRating < ActiveRecord::Migration[7.2]
  def change
    add_column :ratings, :description, :string
  end
end
