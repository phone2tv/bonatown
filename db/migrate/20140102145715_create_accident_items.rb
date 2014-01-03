class CreateAccidentItems < ActiveRecord::Migration
  def change
    create_table :accident_items do |t|
      t.references :accident_insurance, index: true
      t.references :industry, index: true
      t.string :employee_number
      t.integer :quota
      t.date :started_at
      t.date :stopped_at

      t.timestamps
    end
  end
end