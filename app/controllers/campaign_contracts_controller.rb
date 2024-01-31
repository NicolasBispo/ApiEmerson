class CampaignContractsController < ApplicationController
  before_action :set_campaign_contract, only: %i[ show update destroy ]
  before_action :authenticate_user!

  # GET /campaign_contracts
  def index
    @campaign_contracts = CampaignContract.all

    render json: @campaign_contracts
  end

  # GET /campaign_contracts/1
  def show
    render json: @campaign_contract
  end

  # POST /campaign_contracts
  def create
    @campaign_contract = CampaignContract.new(campaign_contract_params)

    if @campaign_contract.save
      render json: @campaign_contract, status: :created, location: @campaign_contract
    else
      render json: @campaign_contract.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /campaign_contracts/1
  def update
    if @campaign_contract.update(campaign_contract_params)
      render json: @campaign_contract
    else
      render json: @campaign_contract.errors, status: :unprocessable_entity
    end
  end

  # DELETE /campaign_contracts/1
  def destroy
    @campaign_contract.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign_contract
      @campaign_contract = CampaignContract.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def campaign_contract_params
      params.require(:campaign_contract).permit(:name, :text, :start_date, :end_date, :status)
    end
end
