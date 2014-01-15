class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, :null => false, :default => ""
    add_column :users, :name, :string
    add_column :users, :card_type, :string
    add_column :users, :card_no, :string
    add_column :users, :birthday, :date
    add_column :users, :gender, :string
    add_column :users, :english_name, :string
    add_column :users, :mobile, :string
    add_column :users, :telephone, :string
    add_column :users, :province, :string
    add_column :users, :city, :string
    add_column :users, :district, :string
    add_column :users, :location, :string
    add_reference :users, :profile, polymorphic: true, index: true
    add_index :users, :username, :unique => true
  end
end
