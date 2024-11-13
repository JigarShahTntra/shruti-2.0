class CriteriasController < ApplicationController
  before_action :set_idea
  before_action :set_criteria, only: :show

  def index
    criterias = @idea.criterias
    render json: criterias, message: "Criterias Fetched Successfully"
  end

  def fetch_criterias
    available_criterias = @idea.criterias.pluck(:criteria_type).uniq
    render json: available_criterias, message: "Criteria Types Fetched Successfully"
  end

  def show
    render json: @criteria, message: "Criteria Fetched Successfully"
  end

  private

  def set_criteria
    @criteria = @idea.criterias.find_by(criteria_type: params[:criteria_type])
  end

  def set_idea
    @idea = Idea.find_by(id: params[:idea_id])
  end
end
