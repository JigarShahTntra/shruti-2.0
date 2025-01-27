class Api::V1::IdeaParameterDetailsController < ::ApplicationController
  before_action :set_idea
  before_action :set_idea_stage_gate, only: [ :show ]
  before_action :set_idea_parameter_detail, only: [ :show ]

  def show
    if @idea
      if @idea.inprogress?
        render json: { status: @idea.status }, message: "Idea is in inprogress."
      else
        render json: @idea_parameter_detail, message: "Idea Parameter Fetched Successfully"
      end
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
      @stage_gate = @idea.idea_stage_gates.find_by_cname(params[:stage_gate_id])
    end
  end

  def set_idea_parameter_detail
    if @stage_gate
      @idea_parameter_detail = @stage_gate.idea_parameter_details.find_by_cname(params[:id])
    end
  end
end
