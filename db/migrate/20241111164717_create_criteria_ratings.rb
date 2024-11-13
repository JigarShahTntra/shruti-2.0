class CreateCriteriaRatings < ActiveRecord::Migration[7.2]
  def change
    create_table :criteria_ratings do |t|
      t.float :rating
      t.string :description
      t.references :criteria, null: false, foreign_key: true

      t.timestamps
    end
  end
end
