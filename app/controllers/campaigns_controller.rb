class CampaignsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign, only: %i[ show update destroy ]
  before_action :set_company
  before_action :has_permission_on_company
  before_action :has_permission_on_campaign, only: %i[show update destroy]
  before_action :check_id_similarity, only: %i[create update]

  # GET /campaigns
  def index
    @campaigns = @company.campaigns

    render json: @campaigns
  end

  # GET /campaigns/1
  def show
    render json: @campaign
  end

  # POST /campaigns
  def create
    @campaign = Campaign.new(campaign_params)

    if @campaign.save
      render json: @campaign, status: :created
    else
      render json: @campaign.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /campaigns/1
  def update
    if @campaign.update(campaign_params)
      render json: @campaign
    else
      render json: @campaign.errors, status: :unprocessable_entity
    end
  end

  # DELETE /campaigns/1
  def destroy
    @campaign.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    def set_company
      @company = Company.find(params[:company_id])
    end

   

    # Only allow a list of trusted parameters through.
    def campaign_params
      params.require(:campaign).permit(:name, :company_id)
    end

    def has_permission_on_company
      unless current_user.id === @company.user.id
        return render json: {message: "Voce não tem permissão de acesso"}, status: :unauthorized
      end
    end

    def has_permission_on_campaign
      unless current_user.id === @campaign.company.user.id
        return render json: {message: "Voce não tem permissão de acesso"}, status: :unauthorized
      end
    end

    def check_id_similarity
      unless params[:campaign_descriptor][:company_id] == params[:company_id]
        return render json: {message: "Voce não tem permissão de acesso"}, status: :unauthorized
      end
    end
end
