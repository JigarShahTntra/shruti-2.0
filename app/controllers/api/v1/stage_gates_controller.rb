class Api::V1::StageGatesController < ::ApplicationController
  before_action :set_idea
  before_action :set_idea_stage_gate, only: [ :show ]
  def index
    if @idea
      render json: @idea.idea_stage_gates, message: "Stage Gates Fetched Successfully"
    else
      render json: { status: false }, message: "Idea have not been sent to process."
    end
  end

  def show
    if @idea
      render json: @stage_gate, message: "Stage Gate Fetched Successfully"
    else
      render json: { status: false }, message: "Idea have not been sent to process."
    end

  end

  private

  def set_idea
    @idea = Idea.find_by(tid: params[:idea_id])
  end

  def set_idea_stage_gate
    if @idea
      @stage_gate = @idea.idea_stage_gates.find_by_cname(params[:id])
    end
  end
end
