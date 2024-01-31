class CreateSocialMediaDescriptors < ActiveRecord::Migration[7.1]
  def change
    create_table :social_media_descriptors do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
