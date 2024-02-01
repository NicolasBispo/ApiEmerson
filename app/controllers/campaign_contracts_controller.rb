class CampaignContractsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign_contract, only: %i[ show update destroy ]
  before_action :set_company
  before_action :set_campaign
  before_action :has_permission_on_company
  before_action :has_permission_on_campaign_contract, only: %i[update destroy]
  before_action :set_users, only: %i[create update]
  

  # GET /campaign_contracts
  def index
    @campaign_contracts = @campaign.campaign_contracts.includes(:users)
    render json: @campaign_contracts, include: { users: { only: [:id, :name, :email, :first_name, :last_name] } }

  end

  # GET /campaign_contracts/1
  def show
    render json: @campaign_contract, include: { users: { only: [:id, :name, :email, :first_name, :last_name] } }
  end

  # POST /campaign_contracts
  def create
    @campaign_contract = CampaignContract.new(campaign_contract_params)

    if @campaign_contract.save
      render json: @campaign_contract, status: :created
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
   
      @campaign_contract =  CampaignContract.includes(:users).find(params[:id])
    end

    def set_campaign
      @campaign = Campaign.find(params[:campaign_id])
    end

    def set_company
      @company = Company.find(params[:company_id])
    end

    def set_users
      if params[:campaign].present? && params[:campaign][:users].present?
        user_ids = params[:campaign][:users].join(',').split(',').map(&:to_i)
        @users = User.where(id: user_ids)
      end
    end

    # Only allow a list of trusted parameters through.
    def campaign_contract_params
      params.require(:campaign_contract).permit(:name, :text, :start_date, :end_date, :status, :campaign_id)
    end

    def has_permission_on_company
      unless current_user.id === @company.user.id
        return render json: {message: "Voce não tem permissão de acesso"}, status: :unauthorized
      end
    end

    def has_permission_on_campaign_contract
      unless current_user.id === @campaign_contract.campaign.company.user.id
        return render json: {message: "Voce não tem permissão de acesso"}, status: :unauthorized
      end
    end

end
