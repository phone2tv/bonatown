class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :code
      t.string :name
      t.string :province_code, index: true

      t.timestamps
    end
  end
end
