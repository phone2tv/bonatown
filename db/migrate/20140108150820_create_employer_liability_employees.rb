class CreateEmployerLiabilityEmployees < ActiveRecord::Migration
  def change
    create_table :employer_liability_employees do |t|
      # we need name index, otherwise generated name will be too long and command 'rake db:migrate' will fail
      t.references :employer_liability_item, index: { name: 'index_employees_on_employer_liability_item_id' }
      t.string :name
      t.string :title
      t.string :health

      t.timestamps
    end
  end
end
