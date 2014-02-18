class CreateCustomerProfiles < ActiveRecord::Migration
  def change
    create_table :customer_profiles do |t|
      t.string :name
      t.string :telephone
      t.string :business_license
      t.string :code_number
      t.string :enterprise_name
      t.string :province_code, index: true
      t.string :city_code, index: true
      t.string :district_code, index: true
      t.string :location
      t.string :zipcode
      t.references :park_profile, index: true

      t.timestamps
    end
  end
end
