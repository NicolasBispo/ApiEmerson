class AddUserToSocialLink < ActiveRecord::Migration[7.1]
  def change
    add_reference :social_links, :user, null: false, foreign_key: true
  end
end
