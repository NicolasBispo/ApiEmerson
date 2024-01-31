class CreateCompanyContracts < ActiveRecord::Migration[7.1]
  def change
    create_table :company_contracts do |t|
      t.string :name
      t.text :text
      t.datetime :start_date
      t.datetime :end_date
      t.string :status

      t.timestamps
    end
  end
end
