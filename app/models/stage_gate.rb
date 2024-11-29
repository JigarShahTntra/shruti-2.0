class StageGate < ApplicationRecord
  has_many :idea_stage_gates
  has_many :ideas, through: :idea_stage_gates
  has_many :stage_gate_parameters
  validates :name, :description, presence: true
  validates_uniqueness_of :name


  def self.find_by_cname(cname)
    where("LOWER(REPLACE(name, ' ', '_')) = ?", cname).first
  end

  def cname
    name.downcase.gsub(" ", "_")
  end
end
