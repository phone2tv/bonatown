class CreateAdminProfiles < ActiveRecord::Migration
  def change
    create_table :admin_profiles do |t|
      t.string :name, default: "", null: false
      t.text :aboutme, default: "", null: false

      t.timestamps
    end
  end
end
