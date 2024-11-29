class IdeaStageGatesController < ApplicationController
  before_action :set_idea_stage_gate, only: %i[ show update destroy ]

  # GET /idea_stage_gates
  def index
    @idea_stage_gates = IdeaStageGate.all

    render json: @idea_stage_gates
  end

  # GET /idea_stage_gates/1
  def show
    render json: @idea_stage_gate
  end

  # POST /idea_stage_gates
  def create
    @idea_stage_gate = IdeaStageGate.new(idea_stage_gate_params)

    if @idea_stage_gate.save
      render json: @idea_stage_gate, status: :created, location: @idea_stage_gate
    else
      render json: @idea_stage_gate.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /idea_stage_gates/1
  def update
    if @idea_stage_gate.update(idea_stage_gate_params)
      render json: @idea_stage_gate
    else
      render json: @idea_stage_gate.errors, status: :unprocessable_entity
    end
  end

  # DELETE /idea_stage_gates/1
  def destroy
    @idea_stage_gate.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea_stage_gate
      @idea_stage_gate = IdeaStageGate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def idea_stage_gate_params
      params.require(:idea_stage_gate).permit(:idea_id, :stage_gate_id)
    end
end
