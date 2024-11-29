require "test_helper"

class StageGatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stage_gate = stage_gates(:one)
  end

  test "should get index" do
    get stage_gates_url, as: :json
    assert_response :success
  end

  test "should create stage_gate" do
    assert_difference("StageGate.count") do
      post stage_gates_url, params: { stage_gate: { description: @stage_gate.description, name: @stage_gate.name } }, as: :json
    end

    assert_response :created
  end

  test "should show stage_gate" do
    get stage_gate_url(@stage_gate), as: :json
    assert_response :success
  end

  test "should update stage_gate" do
    patch stage_gate_url(@stage_gate), params: { stage_gate: { description: @stage_gate.description, name: @stage_gate.name } }, as: :json
    assert_response :success
  end

  test "should destroy stage_gate" do
    assert_difference("StageGate.count", -1) do
      delete stage_gate_url(@stage_gate), as: :json
    end

    assert_response :no_content
  end
end
