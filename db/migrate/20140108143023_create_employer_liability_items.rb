class CreateEmployerLiabilityItems < ActiveRecord::Migration
  def change
    create_table :employer_liability_items do |t|
      t.references :insurance, index: true
      t.integer :business_nature
      t.integer :bodily_injury_limit
      t.integer :medical_expenses_limit
      t.integer :litigation_costs_limit
      t.integer :aggregate_limit
      t.integer :deductibles
      t.integer :each_accident_limit
      t.integer :bodily_injury_aggregate_limit
      t.integer :property_deductibles
      t.integer :employee_number
      t.date :effective_date
      t.date :termination_date

      t.timestamps
    end
  end
end
