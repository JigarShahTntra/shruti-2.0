class CreateCriteria < ActiveRecord::Migration[7.2]
  def change
    create_table :criteria do |t|
      t.string :title
      t.references :idea
      t.integer :criteria_type
      t.string :description

      t.timestamps
    end
  end
end
