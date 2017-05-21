class AddCatagoryidToTopic < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :category_id, :integer
  end
end
