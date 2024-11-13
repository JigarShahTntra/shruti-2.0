class AddConversationTypeToIdeaConversation < ActiveRecord::Migration[7.2]
  def change
    add_column :idea_conversations, :conversation_type, :integer, default: 0
  end
end
