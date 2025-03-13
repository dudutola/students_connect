class AddDescriptionToChapters < ActiveRecord::Migration[7.1]
  def change
    add_column :chapters, :description, :text
  end
end
