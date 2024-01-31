class AddCampaignToCampaignDescriptor < ActiveRecord::Migration[7.1]
  def change
    add_reference :campaign_descriptors, :campaign, null: false, foreign_key: true
  end
end
