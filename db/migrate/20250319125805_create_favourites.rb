class CreateFavourites < ActiveRecord::Migration[7.1]
  def change
    create_table :favourites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :favourited_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
