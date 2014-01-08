class CreateProductLiabilityItems < ActiveRecord::Migration
  def change
    create_table :product_liability_items do |t|
      t.integer :business_nature
      t.integer :each_accident_limit
      t.integer :bodily_injury_limit
      t.integer :property_damage_limit
      t.integer :aggregate_limit
      t.date :started_at
      t.date :stopped_at

      t.timestamps
    end
  end
end
