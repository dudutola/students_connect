class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.references :user, null: false, foreign_key: true
      t.integer :reviewer_id

      t.timestamps
    end
    
    add_index :reviews, :reviewer_id
  end
end
