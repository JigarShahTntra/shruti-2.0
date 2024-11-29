require "test_helper"

class StageGateParametersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stage_gate_parameter = stage_gate_parameters(:one)
  end

  test "should get index" do
    get stage_gate_parameters_url, as: :json
    assert_response :success
  end

  test "should create stage_gate_parameter" do
    assert_difference("StageGateParameter.count") do
      post stage_gate_parameters_url, params: { stage_gate_parameter: { name: @stage_gate_parameter.name, prompt: @stage_gate_parameter.prompt, stage_gate_id: @stage_gate_parameter.stage_gate_id } }, as: :json
    end

    assert_response :created
  end

  test "should show stage_gate_parameter" do
    get stage_gate_parameter_url(@stage_gate_parameter), as: :json
    assert_response :success
  end

  test "should update stage_gate_parameter" do
    patch stage_gate_parameter_url(@stage_gate_parameter), params: { stage_gate_parameter: { name: @stage_gate_parameter.name, prompt: @stage_gate_parameter.prompt, stage_gate_id: @stage_gate_parameter.stage_gate_id } }, as: :json
    assert_response :success
  end

  test "should destroy stage_gate_parameter" do
    assert_difference("StageGateParameter.count", -1) do
      delete stage_gate_parameter_url(@stage_gate_parameter), as: :json
    end

    assert_response :no_content
  end
end
