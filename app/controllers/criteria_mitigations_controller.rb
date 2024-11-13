class CriteriaMitigationsController < ApplicationController
  before_action :set_idea, :set_criteria, only: :show

  def show
    render json: @criteria.criteria_mitigations.last, message: "Criteria Fetched Successfully"
  end

  private

  def set_criteria
    @criteria = @idea.criterias.find_by(criteria_type: params[:criteria_type])
  end

  def set_idea
    @idea = Idea.find_by(id: params[:idea_id])
  end
end
