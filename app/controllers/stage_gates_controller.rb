class StageGatesController < ApplicationController
  before_action :set_stage_gate, only: %i[ show update destroy ]

  # GET /stage_gates
  def index
    @stage_gates = StageGate.all

    render json: @stage_gates
  end

  # GET /stage_gates/1
  def show
    render json: @stage_gate
  end

  # POST /stage_gates
  def create
    @stage_gate = StageGate.new(stage_gate_params)

    if @stage_gate.save
      render json: @stage_gate, status: :created, location: @stage_gate
    else
      render json: @stage_gate.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stage_gates/1
  def update
    if @stage_gate.update(stage_gate_params)
      render json: @stage_gate
    else
      render json: @stage_gate.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stage_gates/1
  def destroy
    @stage_gate.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stage_gate
      @stage_gate = StageGate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stage_gate_params
      params.require(:stage_gate).permit(:name, :description)
    end
end
