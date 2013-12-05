class CreateQuoterProfiles < ActiveRecord::Migration
  def change
    create_table :quoter_profiles do |t|
      t.string :name

      t.timestamps
    end
  end
end
