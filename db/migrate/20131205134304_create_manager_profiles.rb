class CreateManagerProfiles < ActiveRecord::Migration
  def change
    create_table :manager_profiles do |t|
      t.string :name

      t.timestamps
    end
  end
end
