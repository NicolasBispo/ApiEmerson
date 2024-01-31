class CreateJoinTableCampaignContractsUsers < ActiveRecord::Migration[7.1]
  def change
    create_join_table :campaign_contracts, :users do |t|
      # t.index [:campaign_contract_id, :user_id]
      # t.index [:user_id, :campaign_contract_id]
    end
  end
end
