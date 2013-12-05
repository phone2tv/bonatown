class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|
      t.string :name
      t.string :website
      t.text :aboutme
      t.references :user, index: true

      t.timestamps
    end
  end
end
