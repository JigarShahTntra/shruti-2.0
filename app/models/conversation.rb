class Conversation < ApplicationRecord
  belongs_to :conversationable, polymorphic: true
end
