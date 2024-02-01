class SocialLinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_social_link, only: %i[ show update destroy ]
  before_action :has_permission_on_social_link, only: %i[show update destroy]
  before_action :check_id_similarity, only: %i[create update]

  # GET /social_links
  def index
    @social_links = current_user.social_links

    render json: @social_links
  end

  # GET /social_links/1
  def show
    render json: @social_link
  end

  # POST /social_links
  def create
    @social_link = SocialLink.new(social_link_params)

    if @social_link.save
      render json: @social_link, status: :created, location: @social_link
    else
      render json: @social_link.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /social_links/1
  def update
    if @social_link.update(social_link_params)
      render json: @social_link
    else
      render json: @social_link.errors, status: :unprocessable_entity
    end
  end

  # DELETE /social_links/1
  def destroy
    @social_link.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_social_link
      @social_link = SocialLink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def social_link_params
      params.require(:social_link).permit(:name, :url, :user_id)
    end

    def has_permission_on_social_link
      unless current_user.id == @social_link.user.id
        return render json: {message: "Sem permissão de acesso"}, status: :unauthorized
      end
    end

    def check_id_similarity
      unless params[:social_link][:user_id] == current_user.id
        return render json: {message: "Voce não tem permissão de acesso"}, status: :unauthorized
      end
    end
end
