class ChangeMhPsDefault < ActiveRecord::Migration[6.1]
  def up
    change_column :mental_health_professionals, :vetted, :boolean, default: false
  end

  def down
    change_column :mental_health_professionals, :vetted, :boolean, default: nil
  end
end
