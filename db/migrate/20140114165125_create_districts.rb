class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.string :code
      t.string :name
      t.string :city_code, index: true

      t.timestamps
    end
  end
end
