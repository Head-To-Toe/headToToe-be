class ChangeDoctorsDefault < ActiveRecord::Migration[6.1]
  def up
    change_column :doctors, :vetted, :boolean, default: false
  end

  def down
    change_column :doctors, :vetted, :boolean, default: nil
  end
end
