class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.string :aasm_state
      t.string :address

      t.timestamps
    end
  end
end
