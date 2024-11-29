class ParameterRecommendationsController < ApplicationController
  before_action :set_parameter_recommendation, only: %i[ show update destroy ]

  # GET /parameter_recommendations
  def index
    @parameter_recommendations = ParameterRecommendation.where(stage_gate_parameter_id: params[:stage_gate_parameter_id])

    render json: @parameter_recommendations
  end

  # GET /parameter_recommendations/1
  def show
    render json: @parameter_recommendation
  end

  # POST /parameter_recommendations
  def create
    @parameter_recommendation = ParameterRecommendation.new(parameter_recommendation_params)

    if @parameter_recommendation.save
      render json: @parameter_recommendation, status: :created, location: @parameter_recommendation
    else
      render json: @parameter_recommendation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /parameter_recommendations/1
  def update
    if @parameter_recommendation.update(parameter_recommendation_params)
      render json: @parameter_recommendation
    else
      render json: @parameter_recommendation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /parameter_recommendations/1
  def destroy
    @parameter_recommendation.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parameter_recommendation
      @parameter_recommendation = ParameterRecommendation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def parameter_recommendation_params
      params.require(:parameter_recommendation).permit(:stage_gate_parameter_id, :name, :description, :prompt)
    end
end
