class AddUseridToTopic < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :user_id, :integer
  end
end
