class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_one :company
  has_and_belongs_to_many :company_contracts
  has_and_belongs_to_many :campaign_contracts
  has_many :social_links
 
  # def as_json(options = {})
  #   super(options.merge(include: :social_links))
  # end

end