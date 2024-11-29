require "test_helper"

class IdeaStageGatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @idea_stage_gate = idea_stage_gates(:one)
  end

  test "should get index" do
    get idea_stage_gates_url, as: :json
    assert_response :success
  end

  test "should create idea_stage_gate" do
    assert_difference("IdeaStageGate.count") do
      post idea_stage_gates_url, params: { idea_stage_gate: { idea_id: @idea_stage_gate.idea_id, stage_gate_id: @idea_stage_gate.stage_gate_id } }, as: :json
    end

    assert_response :created
  end

  test "should show idea_stage_gate" do
    get idea_stage_gate_url(@idea_stage_gate), as: :json
    assert_response :success
  end

  test "should update idea_stage_gate" do
    patch idea_stage_gate_url(@idea_stage_gate), params: { idea_stage_gate: { idea_id: @idea_stage_gate.idea_id, stage_gate_id: @idea_stage_gate.stage_gate_id } }, as: :json
    assert_response :success
  end

  test "should destroy idea_stage_gate" do
    assert_difference("IdeaStageGate.count", -1) do
      delete idea_stage_gate_url(@idea_stage_gate), as: :json
    end

    assert_response :no_content
  end
end
