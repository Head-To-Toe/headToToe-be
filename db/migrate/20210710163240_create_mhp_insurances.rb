class CreateMhpInsurances < ActiveRecord::Migration[6.1]
  def change
    create_table :mhp_insurances do |t|
      t.references :mental_health_professional
      t.references :insurance

      t.timestamps
    end
  end
end
