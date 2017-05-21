class AddCatagoryidToLink < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :topic_id, :integer
  end
end
