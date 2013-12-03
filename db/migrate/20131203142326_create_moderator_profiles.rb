class CreateModeratorProfiles < ActiveRecord::Migration
  def change
    create_table :moderator_profiles do |t|
      t.string :realname

      t.timestamps
    end
  end
end
