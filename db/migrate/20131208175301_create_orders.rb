class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.string :aasm_state
      t.string :address
      t.string :order_number

      t.timestamps
    end

    add_index :orders, :order_number, :unique => true
  end
end
