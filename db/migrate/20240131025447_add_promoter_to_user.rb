class AddPromoterToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :promoter, :boolean
  end
end
