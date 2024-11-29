class ChangeBodyInConversation < ActiveRecord::Migration[7.2]
  def change
    remove_column :conversations, :body
    add_column :conversations, :body, :jsonb, using: 'body::jsonb'
  end
end
