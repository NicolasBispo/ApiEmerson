class SocialMediaDescriptorsController < ApplicationController
  before_action :set_social_media_descriptor, only: %i[ show update destroy ]

  # GET /social_media_descriptors
  def index
    @social_media_descriptors = SocialMediaDescriptor.all

    render json: @social_media_descriptors
  end

  # GET /social_media_descriptors/1
  def show
    render json: @social_media_descriptor
  end

  # POST /social_media_descriptors
  def create
    @social_media_descriptor = SocialMediaDescriptor.new(social_media_descriptor_params)

    if @social_media_descriptor.save
      render json: @social_media_descriptor, status: :created, location: @social_media_descriptor
    else
      render json: @social_media_descriptor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /social_media_descriptors/1
  def update
    if @social_media_descriptor.update(social_media_descriptor_params)
      render json: @social_media_descriptor
    else
      render json: @social_media_descriptor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /social_media_descriptors/1
  def destroy
    @social_media_descriptor.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_social_media_descriptor
      @social_media_descriptor = SocialMediaDescriptor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def social_media_descriptor_params
      params.require(:social_media_descriptor).permit(:name, :value)
    end
end
