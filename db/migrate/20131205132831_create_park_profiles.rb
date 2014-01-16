class CreateParkProfiles < ActiveRecord::Migration
  def change
    create_table :park_profiles do |t|
      t.string :name
      t.string :park_name
      t.string :location
      t.references :company, index: true

      t.timestamps
    end
  end
end
