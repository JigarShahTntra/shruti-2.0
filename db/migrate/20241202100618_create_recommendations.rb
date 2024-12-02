class CreateRecommendations < ActiveRecord::Migration[7.2]
  def change
    create_table :recommendations do |t|
      t.string :title
      t.string :description
      t.references :recommendable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
