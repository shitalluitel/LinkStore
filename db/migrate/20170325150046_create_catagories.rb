class CreateCatagories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.boolean :favorite

      t.timestamps
    end
  end
end
