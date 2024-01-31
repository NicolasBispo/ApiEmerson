class CampaignContract < ApplicationRecord
    belongs_to :campaign
    has_and_belongs_to_many :users
end
