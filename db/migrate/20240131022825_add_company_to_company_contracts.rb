class AddCompanyToCompanyContracts < ActiveRecord::Migration[7.1]
  def change
    add_reference :company_contracts, :company, null: false, foreign_key: true
  end
end
