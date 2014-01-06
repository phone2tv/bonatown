class CreateInsurances < ActiveRecord::Migration
  def change
    create_table :insurances do |t|
      t.string :title
      t.text :synopsis
      t.decimal :price
      t.string :aasm_state
      t.string :type
      t.references :company, index: true
      t.string :image
      t.string :target
      t.text :feature
      t.text :benefit

      t.timestamps
    end
  end
end
