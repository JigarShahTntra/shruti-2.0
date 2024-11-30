class StageGateParameterGraph < ApplicationRecord
  belongs_to :stage_gate_parameter
  has_one :idea_parameter_graph
end
