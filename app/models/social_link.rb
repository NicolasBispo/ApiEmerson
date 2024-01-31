class SocialLink < ApplicationRecord
    belongs_to :user
    has_many :social_media_descriptors
end

