require "test_helper"

class IdeaParameterDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @idea_parameter_detail = idea_parameter_details(:one)
  end

  test "should get index" do
    get idea_parameter_details_url, as: :json
    assert_response :success
  end

  test "should create idea_parameter_detail" do
    assert_difference("IdeaParameterDetail.count") do
      post idea_parameter_details_url, params: { idea_parameter_detail: { description: @idea_parameter_detail.description, idea_id: @idea_parameter_detail.idea_id, stage_gate_parameter_id: @idea_parameter_detail.stage_gate_parameter_id } }, as: :json
    end

    assert_response :created
  end

  test "should show idea_parameter_detail" do
    get idea_parameter_detail_url(@idea_parameter_detail), as: :json
    assert_response :success
  end

  test "should update idea_parameter_detail" do
    patch idea_parameter_detail_url(@idea_parameter_detail), params: { idea_parameter_detail: { description: @idea_parameter_detail.description, idea_id: @idea_parameter_detail.idea_id, stage_gate_parameter_id: @idea_parameter_detail.stage_gate_parameter_id } }, as: :json
    assert_response :success
  end

  test "should destroy idea_parameter_detail" do
    assert_difference("IdeaParameterDetail.count", -1) do
      delete idea_parameter_detail_url(@idea_parameter_detail), as: :json
    end

    assert_response :no_content
  end
end
