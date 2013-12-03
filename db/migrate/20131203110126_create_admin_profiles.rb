class CreateAdminProfiles < ActiveRecord::Migration
  def change
    create_table :admin_profiles do |t|
      t.string :nickname, default: "", null: false
      t.string :realname, default: "", null: false
      t.text :aboutme, default: "", null: false

      t.timestamps
    end
  end
end
