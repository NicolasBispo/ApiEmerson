class Company < ApplicationRecord
    belongs_to :category, optional: true
    belongs_to :user
    has_many :campaigns
    has_many :company_contracts


end
