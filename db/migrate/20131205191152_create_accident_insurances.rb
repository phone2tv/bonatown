class CreateAccidentInsurances < ActiveRecord::Migration
  def change
    create_table :accident_insurances do |t|
      t.text :body

      t.timestamps
    end
  end
end
