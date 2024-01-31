class AddCompanyToCampaign < ActiveRecord::Migration[7.1]
  def change
    add_reference :campaigns, :company, null: false, foreign_key: true
  end
end
