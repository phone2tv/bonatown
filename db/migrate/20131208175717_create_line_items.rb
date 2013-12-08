class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :insurance, index: true
      t.references :cart, index: true
      t.references :order, index: true
      t.string :workflow_state
      t.decimal :price
      t.integer :quantity

      t.timestamps
    end
  end
end
