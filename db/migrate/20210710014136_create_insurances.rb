class CreateInsurances < ActiveRecord::Migration[6.1]
  def change
    create_table :insurances do |t|
      t.string :company

      t.timestamps
    end
  end
end
