class AddIdeaConversationableIdToIdeaConversation < ActiveRecord::Migration[7.2]
  def change
    add_column :idea_conversations, :idea_conversationable_id, :bigint
    add_column :idea_conversations, :idea_conversationable_type, :string
  end
end
