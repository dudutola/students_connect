class AddSlackUrlToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :slack_url, :string unless column_exists?(:users, :slack_url)
  end
end
