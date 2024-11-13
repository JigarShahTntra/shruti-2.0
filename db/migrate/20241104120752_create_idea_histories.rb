class CreateIdeaHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :idea_histories do |t|
      t.references :idea, null: false, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
