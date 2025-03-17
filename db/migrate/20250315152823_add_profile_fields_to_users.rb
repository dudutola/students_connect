class AddProfileFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :description, :text
    add_column :users, :skills, :text
    add_column :users, :github_url, :string
    add_column :users, :linkedin_url, :string
  end
end
