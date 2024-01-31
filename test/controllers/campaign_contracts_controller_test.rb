require "test_helper"

class CampaignContractsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @campaign_contract = campaign_contracts(:one)
  end

  test "should get index" do
    get campaign_contracts_url, as: :json
    assert_response :success
  end

  test "should create campaign_contract" do
    assert_difference("CampaignContract.count") do
      post campaign_contracts_url, params: { campaign_contract: { end_date: @campaign_contract.end_date, name: @campaign_contract.name, start_date: @campaign_contract.start_date, status: @campaign_contract.status, text: @campaign_contract.text } }, as: :json
    end

    assert_response :created
  end

  test "should show campaign_contract" do
    get campaign_contract_url(@campaign_contract), as: :json
    assert_response :success
  end

  test "should update campaign_contract" do
    patch campaign_contract_url(@campaign_contract), params: { campaign_contract: { end_date: @campaign_contract.end_date, name: @campaign_contract.name, start_date: @campaign_contract.start_date, status: @campaign_contract.status, text: @campaign_contract.text } }, as: :json
    assert_response :success
  end

  test "should destroy campaign_contract" do
    assert_difference("CampaignContract.count", -1) do
      delete campaign_contract_url(@campaign_contract), as: :json
    end

    assert_response :no_content
  end
end
