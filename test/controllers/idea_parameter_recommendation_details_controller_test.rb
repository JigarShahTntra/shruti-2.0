require "test_helper"

class IdeaParameterRecommendationDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @idea_parameter_recommendation_detail = idea_parameter_recommendation_details(:one)
  end

  test "should get index" do
    get idea_parameter_recommendation_details_url, as: :json
    assert_response :success
  end

  test "should create idea_parameter_recommendation_detail" do
    assert_difference("IdeaParameterRecommendationDetail.count") do
      post idea_parameter_recommendation_details_url, params: { idea_parameter_recommendation_detail: { description: @idea_parameter_recommendation_detail.description, idea_parameter_detail_id: @idea_parameter_recommendation_detail.idea_parameter_detail_id, parameter_recommendation_id: @idea_parameter_recommendation_detail.parameter_recommendation_id } }, as: :json
    end

    assert_response :created
  end

  test "should show idea_parameter_recommendation_detail" do
    get idea_parameter_recommendation_detail_url(@idea_parameter_recommendation_detail), as: :json
    assert_response :success
  end

  test "should update idea_parameter_recommendation_detail" do
    patch idea_parameter_recommendation_detail_url(@idea_parameter_recommendation_detail), params: { idea_parameter_recommendation_detail: { description: @idea_parameter_recommendation_detail.description, idea_parameter_detail_id: @idea_parameter_recommendation_detail.idea_parameter_detail_id, parameter_recommendation_id: @idea_parameter_recommendation_detail.parameter_recommendation_id } }, as: :json
    assert_response :success
  end

  test "should destroy idea_parameter_recommendation_detail" do
    assert_difference("IdeaParameterRecommendationDetail.count", -1) do
      delete idea_parameter_recommendation_detail_url(@idea_parameter_recommendation_detail), as: :json
    end

    assert_response :no_content
  end
end
