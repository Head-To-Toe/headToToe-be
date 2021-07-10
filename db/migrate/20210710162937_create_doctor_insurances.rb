class CreateDoctorInsurances < ActiveRecord::Migration[6.1]
  def change
    create_table :doctor_insurances do |t|
      t.references :insurance
      t.references :doctor

      t.timestamps
    end
  end
end
