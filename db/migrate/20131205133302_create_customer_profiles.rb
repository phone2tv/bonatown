class CreateCustomerProfiles < ActiveRecord::Migration
  def change
    create_table :customer_profiles do |t|
      t.string :name
      t.string :enterprise_name
      t.string :location
      t.references :park_profile, index: true

      t.timestamps
    end
  end
end
