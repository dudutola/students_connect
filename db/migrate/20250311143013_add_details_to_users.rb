class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :bio, :text
    add_column :users, :education, :string
    add_column :users, :username, :string
    add_column :users, :name, :string
    add_column :users, :avatar_url, :string
    add_column :users, :location, :string
    add_column :users, :uid, :string
    add_column :users, :provider, :string
  end
end
