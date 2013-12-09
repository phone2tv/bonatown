class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.references :customer_profile, index: true

      t.timestamps
    end
  end
end
