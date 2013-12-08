class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.datetime :deal_time
      t.string :address
      t.string :number

      t.timestamps
    end
  end
end
