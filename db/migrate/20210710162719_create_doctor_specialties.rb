class CreateDoctorSpecialties < ActiveRecord::Migration[6.1]
  def change
    create_table :doctor_specialties do |t|
      t.references :specialty
      t.references :doctor

      t.timestamps
    end
  end
end
