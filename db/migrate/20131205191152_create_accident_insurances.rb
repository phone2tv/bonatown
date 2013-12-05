class CreateAccidentInsurances < ActiveRecord::Migration
  def change
    create_table :accident_insurances do |t|
      t.string :title
      t.text :synopsis
      t.decimal :price
      t.references :company, index: true

      t.timestamps
    end
  end
end
