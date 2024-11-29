class IdeaParameterDetailsController < ApplicationController
  before_action :set_idea_parameter_detail, only: %i[ show update destroy ]

  # GET /idea_parameter_details
  def index
    @idea_parameter_details = IdeaParameterDetail.all

    render json: @idea_parameter_details
  end

  # GET /idea_parameter_details/1
  def show
    render json: @idea_parameter_detail
  end

  # POST /idea_parameter_details
  def create
    @idea_parameter_detail = IdeaParameterDetail.new(idea_parameter_detail_params)

    if @idea_parameter_detail.save
      render json: @idea_parameter_detail, status: :created, location: @idea_parameter_detail
    else
      render json: @idea_parameter_detail.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /idea_parameter_details/1
  def update
    if @idea_parameter_detail.update(idea_parameter_detail_params)
      render json: @idea_parameter_detail
    else
      render json: @idea_parameter_detail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /idea_parameter_details/1
  def destroy
    @idea_parameter_detail.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea_parameter_detail
      @idea_parameter_detail = IdeaParameterDetail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def idea_parameter_detail_params
      params.require(:idea_parameter_detail).permit(:stage_gate_parameter_id, :idea_id, :description)
    end
end
