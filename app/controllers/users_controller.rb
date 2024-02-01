class UsersController < ApplicationController
    before_action :authenticate_user!

    def me
        render json: current_user.as_json(include: :social_links)
    end

    def get_compaign_contracts
        render json: current_user.as_json(include: :campaign_contracts)
    end

    def get_company_contracts
        render json: current_user.as_json(include: :company_contracts)
    end

end
