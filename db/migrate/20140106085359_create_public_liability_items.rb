class CreatePublicLiabilityItems < ActiveRecord::Migration
  def change
    create_table :public_liability_items do |t|
      t.references :insurance, index: true
      t.string :business_place
      t.integer :business_type
      t.boolean :with_fire_control
      t.boolean :with_security_measure

      t.timestamps
    end
  end
end
