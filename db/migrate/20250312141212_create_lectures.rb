class CreateLectures < ActiveRecord::Migration[7.1]
  def change
    create_table :lectures do |t|
      t.string :title
      t.string :group_name
      t.string :resource_url
      t.references :chapter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
