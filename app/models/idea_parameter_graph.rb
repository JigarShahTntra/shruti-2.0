class IdeaParameterGraph < ApplicationRecord
  belongs_to :stage_gate_parameter_graph
  belongs_to :idea_parameter_detail
end
