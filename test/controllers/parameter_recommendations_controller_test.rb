require "test_helper"

class ParameterRecommendationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parameter_recommendation = parameter_recommendations(:one)
  end

  test "should get index" do
    get parameter_recommendations_url, as: :json
    assert_response :success
  end

  test "should create parameter_recommendation" do
    assert_difference("ParameterRecommendation.count") do
      post parameter_recommendations_url, params: { parameter_recommendation: { name: @parameter_recommendation.name, prompt: @parameter_recommendation.prompt, stage_gate_parameter_id: @parameter_recommendation.stage_gate_parameter_id } }, as: :json
    end

    assert_response :created
  end

  test "should show parameter_recommendation" do
    get parameter_recommendation_url(@parameter_recommendation), as: :json
    assert_response :success
  end

  test "should update parameter_recommendation" do
    patch parameter_recommendation_url(@parameter_recommendation), params: { parameter_recommendation: { name: @parameter_recommendation.name, prompt: @parameter_recommendation.prompt, stage_gate_parameter_id: @parameter_recommendation.stage_gate_parameter_id } }, as: :json
    assert_response :success
  end

  test "should destroy parameter_recommendation" do
    assert_difference("ParameterRecommendation.count", -1) do
      delete parameter_recommendation_url(@parameter_recommendation), as: :json
    end

    assert_response :no_content
  end
end
