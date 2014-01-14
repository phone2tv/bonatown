class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :card_type
      t.string :card_no
      t.date :birthday
      t.string :gender
      t.string :english_name
      t.string :mobile
      t.string :telephone
      t.string :province
      t.string :city
      t.string :district
      t.references :customer_profile, index: true

      t.timestamps
    end
  end
end
