class CreateMhpSpecialties < ActiveRecord::Migration[6.1]
  def change
    create_table :mhp_specialties do |t|
      t.references :mental_health_professional
      t.references :specialty

      t.timestamps
    end
  end
end
