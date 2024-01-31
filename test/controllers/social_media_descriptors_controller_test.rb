require "test_helper"

class SocialMediaDescriptorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @social_media_descriptor = social_media_descriptors(:one)
  end

  test "should get index" do
    get social_media_descriptors_url, as: :json
    assert_response :success
  end

  test "should create social_media_descriptor" do
    assert_difference("SocialMediaDescriptor.count") do
      post social_media_descriptors_url, params: { social_media_descriptor: { name: @social_media_descriptor.name, value: @social_media_descriptor.value } }, as: :json
    end

    assert_response :created
  end

  test "should show social_media_descriptor" do
    get social_media_descriptor_url(@social_media_descriptor), as: :json
    assert_response :success
  end

  test "should update social_media_descriptor" do
    patch social_media_descriptor_url(@social_media_descriptor), params: { social_media_descriptor: { name: @social_media_descriptor.name, value: @social_media_descriptor.value } }, as: :json
    assert_response :success
  end

  test "should destroy social_media_descriptor" do
    assert_difference("SocialMediaDescriptor.count", -1) do
      delete social_media_descriptor_url(@social_media_descriptor), as: :json
    end

    assert_response :no_content
  end
end
