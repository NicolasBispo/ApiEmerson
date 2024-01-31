class AddUserToCompany < ActiveRecord::Migration[7.1]
  def change
    add_reference :companies, :user, null: false, foreign_key: true
  end
end
