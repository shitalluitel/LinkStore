class AddCategoryidtolinkToLink < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :category_id, :integer
  end
end
