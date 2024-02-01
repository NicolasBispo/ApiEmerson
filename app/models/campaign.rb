class Campaign < ApplicationRecord
    belongs_to :company
    has_many :campaign_descriptors
    has_many :campaign_contracts
    has_many :users
end
