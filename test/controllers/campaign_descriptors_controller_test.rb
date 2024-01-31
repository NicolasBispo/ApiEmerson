require "test_helper"

class CampaignDescriptorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @campaign_descriptor = campaign_descriptors(:one)
  end

  test "should get index" do
    get campaign_descriptors_url, as: :json
    assert_response :success
  end

  test "should create campaign_descriptor" do
    assert_difference("CampaignDescriptor.count") do
      post campaign_descriptors_url, params: { campaign_descriptor: { name: @campaign_descriptor.name, value: @campaign_descriptor.value } }, as: :json
    end

    assert_response :created
  end

  test "should show campaign_descriptor" do
    get campaign_descriptor_url(@campaign_descriptor), as: :json
    assert_response :success
  end

  test "should update campaign_descriptor" do
    patch campaign_descriptor_url(@campaign_descriptor), params: { campaign_descriptor: { name: @campaign_descriptor.name, value: @campaign_descriptor.value } }, as: :json
    assert_response :success
  end

  test "should destroy campaign_descriptor" do
    assert_difference("CampaignDescriptor.count", -1) do
      delete campaign_descriptor_url(@campaign_descriptor), as: :json
    end

    assert_response :no_content
  end
end
