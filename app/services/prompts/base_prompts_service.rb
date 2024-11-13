module Prompts
  class BasePromptsService
    def initialize(idea_id)
      @idea = Idea.find_by(id: idea_id)
    end
  end
end
