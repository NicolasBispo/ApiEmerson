class AddSocialLinkIdToSocialMediaDescriptors < ActiveRecord::Migration[7.1]
  def change
    add_reference :social_media_descriptors, :social_link, null: false, foreign_key: true
  end
end
