class AddCategoryToCompany < ActiveRecord::Migration[7.1]
  def change
    add_reference :companies, :category, null: false, foreign_key: true
  end
end
