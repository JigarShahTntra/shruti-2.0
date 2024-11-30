class Api::V1::StageGatesController < ::ApplicationController
  before_action :set_idea
  before_action :set_idea_stage_gate, only: [ :show ]
  def index
    render json: @idea.stage_gates, message: "Stage Gates Fetched Successfully"
  end

  def show
    render json: @stage_gate, message: "Stage Gate Fetched Successfully"
  end

  private

  def set_idea
    @idea = Idea.find_by(tid: params[:idea_id])
  end

  def set_idea_stage_gate
    @stage_gate = @idea.idea_stage_gates.find_by_cname(params[:id])
  end
end
