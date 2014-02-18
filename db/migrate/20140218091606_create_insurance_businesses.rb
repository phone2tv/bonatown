class CreateInsuranceBusinesses < ActiveRecord::Migration
  def change
    create_table :insurance_businesses do |t|
      t.string :name
      t.string :telephone
      t.string :code_number
      t.string :enterprise_name
      t.string :province, index: true
      t.string :city, index: true
      t.string :district, index: true
      t.string :location
      t.string :zipcode
      # we need name index, otherwise generated name will be too long and command 'rake db:migrate' will fail
      t.references :business_owner, polymorphic: true, index: { name: 'index_insurance_businesses_on_business_owner' }

      t.timestamps
    end
  end
end
