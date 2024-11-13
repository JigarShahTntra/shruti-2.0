class CreateIdeaConversations < ActiveRecord::Migration[7.2]
  def change
    create_table :idea_conversations do |t|
      t.json :conversation
      t.references :idea, null: false, foreign_key: true

      t.timestamps
    end
  end
end
