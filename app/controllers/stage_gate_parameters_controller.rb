class StageGateParametersController < ApplicationController
  before_action :set_stage_gate_parameter, only: %i[ show update destroy ]

  # GET /stage_gate_parameters
  def index
    @stage_gate_parameters = StageGateParameter.all

    render json: @stage_gate_parameters
  end

  # GET /stage_gate_parameters/1
  def show
    render json: @stage_gate_parameter
  end

  # POST /stage_gate_parameters
  def create
    @stage_gate_parameter = StageGateParameter.new(stage_gate_parameter_params)

    if @stage_gate_parameter.save
      render json: @stage_gate_parameter, status: :created, location: @stage_gate_parameter
    else
      render json: @stage_gate_parameter.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stage_gate_parameters/1
  def update
    if @stage_gate_parameter.update(stage_gate_parameter_params)
      render json: @stage_gate_parameter
    else
      render json: @stage_gate_parameter.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stage_gate_parameters/1
  def destroy
    @stage_gate_parameter.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stage_gate_parameter
      @stage_gate_parameter = StageGateParameter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stage_gate_parameter_params
      params.require(:stage_gate_parameter).permit(:stage_gate_id, :name, :description, :prompt)
    end
end
