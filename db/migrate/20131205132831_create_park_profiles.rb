class CreateParkProfiles < ActiveRecord::Migration
  def change
    create_table :park_profiles do |t|
      t.string :name

      t.timestamps
    end
  end
end
