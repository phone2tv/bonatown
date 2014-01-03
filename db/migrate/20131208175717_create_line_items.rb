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

      t.timestamps
    end
  end
end
