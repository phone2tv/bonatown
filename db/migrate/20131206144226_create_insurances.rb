class CreateInsurances < ActiveRecord::Migration
  def change
    create_table :insurances do |t|
      t.string :title
      t.text :synopsis
      t.decimal :price
      t.string :workflow_state
      t.references :company, index: true
      t.references :profile, polymorphic: true, index: true

      t.timestamps
    end
  end
end
