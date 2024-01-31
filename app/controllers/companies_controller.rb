class CompaniesController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_company, only: %i[ show update destroy get_company_contracts get_campaigns ]
  before_action :has_permission_on_company, only: %i[ show update destroy get_company_contracts get_campaigns ]

  # GET /companies
  def index
    @companies = Company.all

    render json: @companies
  end

  def get_company_contracts
    @company_contracts = @company.company_contracts
    render json: @company_contracts
  end
  
  def get_campaigns
    @company_campaigns = @company.campaigns
    render json: @company_campaigns
  end

  # GET /companies/1
  def show
    render json: @company
  end

  # POST /companies
  def create
    @company = Company.new(company_params)

    @company.user = current_user
    if @company.save
      render json: @company, status: :created, location: @company
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /companies/1
  def update
    if @company.update(company_params)
      render json: @company
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  # DELETE /companies/1
  def destroy
    @company.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company).permit(:name, :cnpj)
    end

    def has_permission_on_company
      unless current_user.id === @company.user.id
        return render json: {message: "Sem permissao"}, status: :unauthorized
      end
    end
end
