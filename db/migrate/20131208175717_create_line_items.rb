class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :insurance_item, polymorphic: true, index: true
      t.references :user, index: true
      t.references :cart, index: true
      t.references :order, index: true
      t.string :aasm_state
      t.decimal :price
      t.integer :quantity, default: 1, null: false
      t.integer :lock_version, default: 0, null: false
      t.string :name
      t.string :telephone
      t.string :code_number
      t.string :enterprise_name
      t.string :province, index: true
      t.string :city, index: true
      t.string :district, index: true
      t.string :location
      t.string :zipcode

      t.timestamps
    end
  end
end
