class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.datetime :deal_time
      t.string :address

      t.timestamps
    end
  end
end
