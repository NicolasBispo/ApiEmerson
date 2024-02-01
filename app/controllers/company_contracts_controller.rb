class CompanyContractsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company_contract, only: %i[ show update destroy ]
  before_action :set_company
  before_action :has_permission_on_company
  before_action :has_permission_on_company_contract, only: %i[update destroy show]
  


  # GET id/company_contracts
  def index
    
    @company_contracts = @company.company_contracts

    render json: @company_contracts
  end

  # GET id/company_contracts/1
  def show
    @company_contract = CompanyContract.find(params[:id])
    render json: @company_contract
  end

  # POST id/company_contracts
  def create

    @company_contract = CompanyContract.new(company_contract_params)
    if @company_contract.save
      render json: @company_contract, status: :created
    else
      render json: @company_contract.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /company_contracts/1
  def update
    if @company_contract.update(company_contract_params)
      render json: @company_contract
    else
      render json: @company_contract.errors, status: :unprocessable_entity
    end
  end

  # DELETE /company_contracts/1
  def destroy
    @company_contract.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_contract
      @company_contract = CompanyContract.find(params[:id])
      
    end

    def set_company
      @company = Company.find(params[:company_id])
    end

    # Only allow a list of trusted parameters through.
    def company_contract_params
      params.require(:company_contract).permit(:name, :text, :start_date, :end_date, :status, :company_id)
    end

    def has_permission_on_company
      unless current_user.id === @company.user.id
        return render json: {message: "Voce não tem permissão de acesso"}, status: :unauthorized
      end
    end

    def has_permission_on_company_contract
      unless current_user.id === @company_contract.company.user.id
        return render json: {message: "Voce não tem permissão de acesso"}, status: :unauthorized
      end
    end
end
