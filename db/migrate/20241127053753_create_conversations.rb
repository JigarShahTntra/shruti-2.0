class CreateConversations < ActiveRecord::Migration[7.2]
  def change
    create_table :conversations do |t|
      t.timestamps
      t.json :body
      t.references :conversationable, polymorphic: true, null: false
    end
  end
end
