class CampaignDescriptorsController < ApplicationController
  before_action :set_campaign_descriptor, only: %i[ show update destroy ]

  # GET /campaign_descriptors
  def index
    @campaign_descriptors = CampaignDescriptor.all

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
      render json: @campaign_descriptor, status: :created, location: @campaign_descriptor
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
      params.require(:campaign_descriptor).permit(:name, :value)
    end
end
