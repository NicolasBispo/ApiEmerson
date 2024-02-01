class CampaignDescriptorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign_descriptor, only: %i[ show update destroy ]
  before_action :set_company
  before_action :set_campaign
  before_action :has_permission_on_company
  before_action :has_permission_on_campaign_descriptor, only: %i[update destroy]
  before_action :check_id_similarity, only: %i[create update]
 
  # GET /campaign_descriptors
  def index
    @campaign_descriptors = @campaign.campaign_descriptors

    render json: @campaign_descriptors
  end

  # GET /campaign_descriptors/1
  def show
    render json: @campaign_descriptor
  end

  # POST /campaign_descriptors
  def create
    @campaign_descriptor = CampaignDescriptor.new(campaign_descriptor_params)

    if @campaign_descriptor.save
      render json: @campaign_descriptor, status: :created
    else
      render json: @campaign_descriptor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /campaign_descriptors/1
  def update
    if @campaign_descriptor.update(campaign_descriptor_params)
      render json: @campaign_descriptor
    else
      render json: @campaign_descriptor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /campaign_descriptors/1
  def destroy
    @campaign_descriptor.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign_descriptor
      @campaign_descriptor = CampaignDescriptor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def campaign_descriptor_params
      params.require(:campaign_descriptor).permit(:name, :value, :company_id)
    end

    def set_campaign
      @campaign = Campaign.find(params[:campaign_id])
    end

    def set_company
      @company = Company.find(params[:company_id])
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

    def has_permission_on_campaign_descriptor
      unless current_user.id === @campaign_descriptor.campaign.company.user.id
        return render json: {message: "Voce não tem permissão de acesso"}, status: :unauthorized
      end
    end

    def check_id_similarity
      unless params[:campaign_descriptor][:company_id] == params[:company_id]
        return render json: {message: "Voce não tem permissão de acesso"}, status: :unauthorized
      end
    end
end
