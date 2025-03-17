class AddOverviewToChapters < ActiveRecord::Migration[7.1]
  def change
    add_column :chapters, :overview, :text
  end
end
