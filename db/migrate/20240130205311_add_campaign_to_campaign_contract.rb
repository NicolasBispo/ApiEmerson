class AddCampaignToCampaignContract < ActiveRecord::Migration[7.1]
  def change
    add_reference :campaign_contracts, :campaign, null: false, foreign_key: true
  end
end
