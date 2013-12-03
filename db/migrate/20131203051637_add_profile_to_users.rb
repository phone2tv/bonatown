class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, :null => false, :default => ""
    add_index :users, :username, :unique => true
    add_reference :users, :profile, polymorphic: true, index: true
  end
end
