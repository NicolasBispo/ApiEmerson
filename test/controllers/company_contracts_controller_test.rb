require "test_helper"

class CompanyContractsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company_contract = company_contracts(:one)
  end

  test "should get index" do
    get company_contracts_url, as: :json
    assert_response :success
  end

  test "should create company_contract" do
    assert_difference("CompanyContract.count") do
      post company_contracts_url, params: { company_contract: { end_date: @company_contract.end_date, name: @company_contract.name, start_date: @company_contract.start_date, status: @company_contract.status, text: @company_contract.text } }, as: :json
    end

    assert_response :created
  end

  test "should show company_contract" do
    get company_contract_url(@company_contract), as: :json
    assert_response :success
  end

  test "should update company_contract" do
    patch company_contract_url(@company_contract), params: { company_contract: { end_date: @company_contract.end_date, name: @company_contract.name, start_date: @company_contract.start_date, status: @company_contract.status, text: @company_contract.text } }, as: :json
    assert_response :success
  end

  test "should destroy company_contract" do
    assert_difference("CompanyContract.count", -1) do
      delete company_contract_url(@company_contract), as: :json
    end

    assert_response :no_content
  end
end
