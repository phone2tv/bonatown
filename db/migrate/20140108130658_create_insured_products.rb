class CreateInsuredProducts < ActiveRecord::Migration
  def change
    create_table :insured_products do |t|
      t.references :product_liability_item, index: true
      t.string :name
      t.string :kind
      t.string :nature
      t.string :use
      t.string :sales_area
      t.string :sales_volumn

      t.timestamps
    end
  end
end
