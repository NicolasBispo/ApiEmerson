class CreateJoinTableCompanyContractsUsers < ActiveRecord::Migration[7.1]
  def change
    create_join_table :company_contracts, :users do |t|
      # t.index [:company_contract_id, :user_id]
      # t.index [:user_id, :company_contract_id]
    end
  end
end
