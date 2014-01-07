class CreateElevators < ActiveRecord::Migration
  def change
    create_table :elevators do |t|
      t.references :public_liability_item, index: true
      t.string :kind
      t.integer :quantity
      t.date :year_of_manufacture
      t.integer :using_years
      t.integer :overhaul_interval

      t.timestamps
    end
  end
end
