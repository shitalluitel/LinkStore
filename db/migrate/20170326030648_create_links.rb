class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.string :name
      t.text :link
      t.text :description
      t.integer :user_id
      t.boolean :favorite

      t.timestamps
    end
  end
end
